import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/database_service.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/models/product.dart';
import 'package:never_out/services/sync_service.dart';

class ProductRepository {
  ProductRepository({
    DatabaseService? databaseService,
    Connectivity? connectivity,
    BackendService? backendService,
    SyncService? syncService,
  }) : databaseService = databaseService ?? DatabaseService(),
       connectivity = connectivity ?? Connectivity(),
       _backendService = backendService,
       _syncService = syncService;

  final DatabaseService databaseService;
  final Connectivity connectivity;
  final BackendService? _backendService;
  final SyncService? _syncService;

  late final BackendService backendService =
      _backendService ?? BackendService();

  late final SyncService syncService =
      _syncService ??
      SyncService(
        databaseService: databaseService,
        backendService: backendService,
        connectivity: connectivity,
      );

  Future<List<Product>> getProducts() async {
    return databaseService.products();
  }

  Future<void> addProduct(Product product) async {
    try {
      await databaseService.addProduct(product);
    } catch (e) {
      throw Exception('Error Adding Product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await databaseService.updateProduct(product);
    } catch (e) {
      throw Exception('Error Updating Product: $e');
    }
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await databaseService.deleteProduct(product);
    } catch (e) {
      throw Exception('Error Deleting Product: $e');
    }
  }

  Future<void> syncPendingProducts() async {
    await syncService.syncPendingProducts();
  }
}
