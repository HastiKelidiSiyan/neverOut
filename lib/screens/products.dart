import 'package:flutter/material.dart';
import 'package:never_out/models/app_failure.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/screens/new_product.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/widgets/products_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/providers/products_provider.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final productsNotifier = ref.read(productsProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xSmall),
        child: _buildBody(context, products, productsNotifier),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);

          final newProduct = await navigator.push<ProductModel>(
            MaterialPageRoute(
              builder: (context) => const NewProductScreen(),
            ),
          );

          if (newProduct != null) {
            try {
              await productsNotifier.addProduct(newProduct);
            } on AppFailure catch (failure) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(failureMessage(failure)),
                ),
              );
            }
            final result = await productsNotifier.syncProducts();
            if (result) {
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Sync completed successfully.'),
                ),
              );
            } else {
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Sync failed. Please check your connection.'),
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
    List<ProductModel> products,
    ProductsNotifier productsNotifier,
  ) {
    final textTheme = Theme.of(context).textTheme;

    if (productsNotifier.isLoading && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productsNotifier.error != null && products.isEmpty) {
      return Center(
        child: Text(
          productsNotifier.error.toString(),
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
