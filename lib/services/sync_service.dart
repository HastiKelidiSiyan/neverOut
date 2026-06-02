import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/database_service.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/models/product.dart';

class SyncService {
  final Connectivity connectivity;
  final DatabaseService databaseService;
  final BackendService backendService;

  StreamSubscription? _subscription;

  SyncService({
    required this.connectivity,
    required this.databaseService,
    required this.backendService,
  });

  void startListening() {
    _subscription = connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        if (result.contains(ConnectivityResult.none)) {
          return;
        }
        await syncPendingProducts();
      },
    );
  }

  Future<void> syncPendingProducts() async {
    final pendingProducts = await databaseService.getPendingProducts();

    if (pendingProducts.isEmpty) {
      return;
    }

    for (final product in pendingProducts) {
      switch (product.syncStatus) {
        case SyncStatus.pendingCreate:
          await backendService.addProduct(product);
          await databaseService.updateProductSyncStatus(product);
          break;

        case SyncStatus.pendingUpdate:
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

  void dispose() {
    _subscription?.cancel();
  }
}
