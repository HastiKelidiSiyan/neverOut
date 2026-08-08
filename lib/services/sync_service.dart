import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/local_data_source.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/database/database.dart';
import 'package:never_out/models/product_model.dart';

class SyncService {
  SyncService({
    LocalDataSource? localDataSource,
    BackendService? backendService,
    Connectivity? connectivity,
  }) : localDataSource = localDataSource ?? LocalDataSource(AppDatabase()),
       backendService = backendService ?? BackendService(),
       connectivity = connectivity ?? Connectivity();

  final LocalDataSource localDataSource;
  final BackendService backendService;
  final Connectivity connectivity;

  Future<bool> syncPendingProducts() async {
    final List<ConnectivityResult> connectivityResult = await connectivity
        .checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      final pendingProducts = await localDataSource.getPendingProducts();

      if (pendingProducts.isEmpty) {
        return true;
      }

      for (final product in pendingProducts) {
        switch (product.syncStatus) {
          case SyncStatus.pendingCreate:
            final fetchedProduct = await backendService.findProduct(product);

            if (fetchedProduct == null) {
              await backendService.addProduct(product);
              final createdProduct = await backendService.getProduct(product);
              await localDataSource.updateProductServerId(createdProduct);
            } else {
              product.serverId = fetchedProduct.serverId;
              await backendService.updateProduct(product);
              await localDataSource.updateProductServerId(product);
            }

            await localDataSource.updateProductSyncStatus(
              product,
              SyncStatus.synced,
            );
            break;

          case SyncStatus.pendingUpdate:
            if (product.serverId == null) {
              final fetchedProduct = await backendService.findProduct(product);

              if (fetchedProduct == null) {
                await backendService.addProduct(product);
                final createdProduct = await backendService.getProduct(product);
                await localDataSource.updateProductServerId(createdProduct);
                await localDataSource.updateProductSyncStatus(
                  product,
                  SyncStatus.synced,
                );
                break;
              }

              product.serverId = fetchedProduct.serverId;
              await localDataSource.updateProductServerId(product);
            }

            await backendService.updateProduct(product);
            await localDataSource.updateProductSyncStatus(
              product,
              SyncStatus.synced,
            );
            break;

          case SyncStatus.pendingDelete:
            await backendService.deleteProduct(product);
            await localDataSource.updateProductSyncStatus(
              product,
              SyncStatus.deleted,
            );
            await syncPendingProducts();
            break;

          case SyncStatus.deleted:
            await localDataSource.deleteProduct(product);
            break;

          default:
            break;
        }
      }
      return true;
    } else {
      return false;
    }
  }
}
