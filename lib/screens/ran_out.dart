import 'package:flutter/material.dart';
import 'package:never_out/models/product.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/widgets/products_list.dart';

class RanOutScreen extends StatelessWidget {
  const RanOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProviderScope.watch(context);
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    final products = productsProvider.products.where((product) {
      return product.isLow;
    }).toList();
    final error = productsProvider.error;

    return Scaffold(
      backgroundColor: appColors.ranOutBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xSmall),
        child: _buildBody(context, productsProvider, products, error),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProductsProvider productsProvider,
    List<Product> products,
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
        child: Text(
          'Yay Nothing is Out!',
          style: textTheme.bodyLarge!.copyWith(fontSize: 25),
        ),
      );
    }

    return ProductsList(products: products);
  }
}
