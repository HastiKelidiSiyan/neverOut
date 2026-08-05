import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/local_data_source.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/database/database.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/services/sync_service.dart';

class ProductRepository {
  ProductRepository({
    LocalDataSource? localDataSource,
    Connectivity? connectivity,
    BackendService? backendService,
    SyncService? syncService,
  }) : localDataSource = localDataSource ?? LocalDataSource(AppDatabase()),
       connectivity = connectivity ?? Connectivity(),
       _backendService = backendService,
       _syncService = syncService;

  final LocalDataSource localDataSource;
  final Connectivity connectivity;
  final BackendService? _backendService;
  final SyncService? _syncService;

  late final BackendService backendService =
      _backendService ?? BackendService();

  late final SyncService syncService =
      _syncService ??
      SyncService(
        localDataSource: localDataSource,
        backendService: backendService,
        connectivity: connectivity,
      );

  Future<List<ProductModel>> getProducts() async {
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
    await localDataSource.updateProductSyncStatus(
      product,
      SyncStatus.pendingDelete,
    );
  }

  Future<bool> syncPendingProducts() async {
    return await syncService.syncPendingProducts();
  }
}
