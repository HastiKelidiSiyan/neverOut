import 'dart:async';

import 'package:flutter/material.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/repositories/product_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductsProvider(this.productRepository);

  List<ProductModel> _products = [];

  List<ProductModel> get products => List.unmodifiable(_products);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final products = await productRepository.getProducts();

      _products = products
          .where(
            (product) => product.syncStatus != SyncStatus.pendingDelete,
          )
          .toList();
    } catch (error) {
      _error = error;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await productRepository.addProduct(product);
    } catch (e) {
      throw Exception(e);
    }

    await loadProducts();
    unawaited(syncProducts());
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel updatedProduct) async {
    await productRepository.updateProduct(updatedProduct);

    await loadProducts();
    unawaited(syncProducts());
    notifyListeners();
  }

  Future<void> deleteProduct(ProductModel product) async {
    await productRepository.deleteProduct(product);

    await loadProducts();
    unawaited(syncProducts());
    notifyListeners();
  }

  Future<void> setDeleted(ProductModel product) async {
    await productRepository.setDeleted(product);

    await loadProducts();
    unawaited(syncProducts());
    notifyListeners();
  }

  Future<void> syncProducts() async {
    _isSyncing = true;
    _error = null;
    notifyListeners();

    try {
      await productRepository.syncPendingProducts();
      await loadProducts();
    } catch (error) {
      _error = error;
    }

    _isSyncing = false;
    notifyListeners();
  }
}

class ProductsProviderScope extends InheritedNotifier<ProductsProvider> {
  const ProductsProviderScope({
    super.key,
    required ProductsProvider provider,
    required super.child,
  }) : super(notifier: provider);

  static ProductsProvider watch(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<ProductsProviderScope>();

    assert(widget != null, 'No provider found');

    return widget!.notifier!;
  }

  static ProductsProvider read(BuildContext context) {
    final widget = context
        .getInheritedWidgetOfExactType<ProductsProviderScope>();

    assert(widget != null, 'No provider found');

    return widget!.notifier!;
  }

  static ProductsProvider of(BuildContext context) {
    return watch(context);
  }
}
