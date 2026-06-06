import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/database_service.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/models/product.dart';

class SyncService {
  SyncService({
    DatabaseService? databaseService,
    BackendService? backendService,
    Connectivity? connectivity,
  }) : databaseService = databaseService ?? DatabaseService(),
       backendService = backendService ?? BackendService(),
       connectivity = connectivity ?? Connectivity();

  final DatabaseService databaseService;
  final BackendService backendService;
  final Connectivity connectivity;

  Future<void> syncPendingProducts() async {
    final List<ConnectivityResult> connectivityResult = await connectivity
        .checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      final pendingProducts = await databaseService.getPendingProducts();

      if (pendingProducts.isEmpty) {
        return;
      }

      for (final product in pendingProducts) {
        switch (product.syncStatus) {
          case SyncStatus.pendingCreate:
            final fetchedProduct = await backendService.findProduct(product);

            if (fetchedProduct == null) {
              await backendService.addProduct(product);
              final createdProduct = await backendService.getProduct(product);
              await databaseService.updateProductServerId(createdProduct);
            } else {
              product.serverId = fetchedProduct.serverId;
              await backendService.updateProduct(product);
              await databaseService.updateProductServerId(product);
            }

            await databaseService.updateProductSyncStatus(product);
            break;

          case SyncStatus.pendingUpdate:
            if (product.serverId == null) {
              final fetchedProduct = await backendService.findProduct(product);

              if (fetchedProduct == null) {
                await backendService.addProduct(product);
                final createdProduct = await backendService.getProduct(product);
                await databaseService.updateProductServerId(createdProduct);
                await databaseService.updateProductSyncStatus(product);
                break;
              }

              product.serverId = fetchedProduct.serverId;
              await databaseService.updateProductServerId(product);
            }

            await backendService.updateProduct(product);
            await databaseService.updateProductSyncStatus(product);
            break;

          case SyncStatus.pendingDelete:
            await backendService.deleteProduct(product);
            await databaseService.updateProductSyncStatus(product);
            break;

          default:
            break;
        }
      }
    }
  }
}
