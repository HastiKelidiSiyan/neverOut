import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/repositories/product_repository.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<ProductModel>>((ref) {
      return ProductsNotifier(ProductRepository())..loadProducts();
    });

class ProductsNotifier extends StateNotifier<List<ProductModel>> {
  final ProductRepository productRepository;

  ProductsNotifier(this.productRepository) : super(const []);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;

    final products = await productRepository.getProducts();

    state = products
        .where(
          (product) => product.syncStatus != SyncStatus.pendingDelete,
        )
        .toList();

    _isLoading = false;
  }

  Future<void> addProduct(ProductModel product) async {
    await productRepository.addProduct(product);

    await loadProducts();
    unawaited(syncProducts());
  }

  Future<void> updateProduct(ProductModel updatedProduct) async {
    await productRepository.updateProduct(updatedProduct);

    await loadProducts();
    unawaited(syncProducts());
  }

  Future<void> deleteProduct(ProductModel product) async {
    await productRepository.deleteProduct(product);

    await loadProducts();
    unawaited(syncProducts());
  }

  Future<void> setDeleted(ProductModel product) async {
    await productRepository.setDeleted(product);

    await loadProducts();
    unawaited(syncProducts());
  }

  Future<void> syncProducts() async {
    _isSyncing = true;
    _error = null;

    await productRepository.syncPendingProducts();
    await loadProducts();

    _isSyncing = false;
  }
}
