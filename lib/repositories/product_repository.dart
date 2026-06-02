import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:never_out/data/local/database_service.dart';
import 'package:never_out/data/remote/backend_service.dart';
import 'package:never_out/models/product.dart';

class ProductRepository {
  ProductRepository({
    DatabaseService? databaseService,
    Connectivity? connectivity,
    BackendService? backendService,
  }) : databaseService = databaseService ?? DatabaseService(),
       connectivity = connectivity ?? Connectivity(),
       _backendService = backendService;

  final DatabaseService databaseService;
  final Connectivity connectivity;
  final BackendService? _backendService;

  late final BackendService backendService = _backendService ?? BackendService();

  Future<List<Product>> getProducts() async {
    return databaseService.products();
  }

  Future<void> fetchProducts() async {
    final fetchedProducts = await backendService.fetchProducts();

    for (final product in fetchedProducts) {
      if (product.syncStatus == SyncStatus.synced) {
        await databaseService.updateProductSyncStatus(product);
      }
    }
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
}
