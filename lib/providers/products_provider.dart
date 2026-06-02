import 'package:flutter/material.dart';
import 'package:never_out/models/product.dart';
import 'package:never_out/repositories/product_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductsProvider(this.productRepository);

  List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await productRepository.getProducts();
    } catch (error) {
      _error = error;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      await productRepository.addProduct(product);
    } catch (e) {
      throw Exception(e);
    }

    _products = [..._products, product];
    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    await productRepository.updateProduct(updatedProduct);

    final index = _products.indexWhere(
      (e) => e.databaseId == updatedProduct.databaseId,
    );

    if (index == -1) {
      _products = [..._products, updatedProduct];
    } else {
      _products = [
        ..._products.take(index),
        updatedProduct,
        ..._products.skip(index + 1),
      ];
    }

    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    await productRepository.deleteProduct(product);

    _products = _products
        .where((e) => e.databaseId != product.databaseId)
        .toList();

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
