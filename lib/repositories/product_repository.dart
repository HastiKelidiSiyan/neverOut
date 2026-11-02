import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/local_data_source.dart';
import 'package:never_out/data/remote/remote_data_source.dart';
import 'package:never_out/database/database.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/services/sync_service.dart';

class ProductRepository {
  ProductRepository({
    LocalDataSource? localDataSource,
    Connectivity? connectivity,
    RemoteDataSource? backendService,
    SyncService? syncService,
  }) : localDataSource = localDataSource ?? LocalDataSource(AppDatabase()),
       connectivity = connectivity ?? Connectivity(),
       backendService = backendService ?? RemoteDataSource(),
       _syncService = syncService;

  final LocalDataSource localDataSource;
  final Connectivity connectivity;
  final RemoteDataSource? backendService;
  final SyncService? _syncService;


  late final SyncService syncService =
      _syncService ??
      SyncService(
        localDataSource: localDataSource,
        backendService: backendService,
        connectivity: connectivity,
      );

  Future<List<ProductModel>> getProducts() {
    return localDataSource.getProducts();
  }

  Future<void> addProduct(ProductModel product) async {
    await localDataSource.addProduct(product);
  }

  Future<void> updateProduct(ProductModel product) async {
    await localDataSource.updateProduct(product);
  }

  Future<void> deleteProduct(ProductModel product) async {
    await localDataSource.deleteProduct(product);
  }

  Future<void> setDeleted(ProductModel product) async {
    if (product.syncStatus == SyncStatus.pendingCreate) {
      deleteProduct(product);
      return;
    }
    
    await localDataSource.updateProductSyncStatus(
      product,
      SyncStatus.pendingDelete,
    );
  }

  Future<bool> syncPendingProducts() {
    return syncService.syncPendingProducts();
  }
}
