import 'package:flutter/material.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/screens/new_product.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/widgets/products_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProviderScope.watch(context);
    final products = productsProvider.products;
    final error = productsProvider.error;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xSmall),
        child: _buildBody(context, productsProvider, products, error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);
          final productsProvider = ProductsProviderScope.read(context);

          final newProduct = await navigator.push<ProductModel>(
            MaterialPageRoute(
              builder: (context) => const NewProductScreen(),
            ),
          );

          if (newProduct != null) {
            try {
              await productsProvider.addProduct(newProduct);
            } catch (e) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          }
          return;
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProductsProvider productsProvider,
    List<ProductModel> products,
    Object? error,
  ) {
    final textTheme = Theme.of(context).textTheme;

    if (productsProvider.isLoading && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null && products.isEmpty) {
      return Center(
        child: Text(
          error.toString(),
          style: textTheme.bodyLarge!.copyWith(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... There is nothing here!',
              style: textTheme.bodyLarge!.copyWith(fontSize: 25),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Start by adding some products',
              style: textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return ProductsList(products: products);
  }
}
