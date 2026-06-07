import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data_sources/local/local_data_source.dart';
import 'package:never_out/data_sources/remote/backend_service.dart';
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
    return localDataSource.products();
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await localDataSource.addProduct(product);
    } catch (e) {
      throw Exception('Error Adding Product: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await localDataSource.updateProduct(product);
    } catch (e) {
      throw Exception('Error Updating Product: $e');
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await localDataSource.deleteProduct(product);
    } catch (e) {
      throw Exception('Error Deleting Product: $e');
    }
  }

  Future<void> setDeleted(ProductModel product) async {
    try {
      await localDataSource.updateProductSyncStatus(
        product,
        SyncStatus.pendingDelete,
      );
    } catch (e) {
      throw Exception('Error Deleting Product: $e');
    }
  }

  Future<void> syncPendingProducts() async {
    await syncService.syncPendingProducts();
  }
}
