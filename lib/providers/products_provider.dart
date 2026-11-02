import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/models/app_failure.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/repositories/product_repository.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<ProductModel>>((ref) {
      return ProductsNotifier()..loadProducts();
    });

class ProductsNotifier extends StateNotifier<List<ProductModel>> {
  ProductsNotifier({ProductRepository? productRepository})
    : productRepository = productRepository ?? ProductRepository(),
      super(const []);

  final ProductRepository productRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AppFailure? _error;

  AppFailure? get error => _error;

  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<void> loadProducts() async {
    _isLoading = true;

    try {
      final products = await productRepository.getProducts();

      state = products
          .where(
            (product) => product.syncStatus != SyncStatus.pendingDelete,
          )
          .toList();
    } catch (e) {
      _error = e as AppFailure?;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await productRepository.addProduct(product);
    } catch (e) {
      _error = e as AppFailure?;
    }
    await loadProducts();
  }

  Future<void> updateProduct(ProductModel updatedProduct) async {
    try {
      await productRepository.updateProduct(updatedProduct);
    } catch (e) {
      _error = e as AppFailure?;
    }
    await loadProducts();
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await productRepository.setDeleted(product);
    } catch (e) {
      _error = e as AppFailure?;
    }
    await loadProducts();
  }

  Future<bool> syncProducts() async {
    _isSyncing = true;
    var result = false;

    try {
      result = await productRepository.syncPendingProducts();
    } catch (e) {
      _error = e as AppFailure?;
    } finally {
      _isSyncing = false;
    }
    await loadProducts();
    return result;
  }
}
