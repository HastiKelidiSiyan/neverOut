import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/widgets/products_list.dart';

class RanOutScreen extends ConsumerWidget {
  const RanOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsNotifier = ref.read(productsProvider.notifier);
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    final products = ref.watch(productsProvider).where((product) {
      return product.isLow;
    }).toList();

    return Scaffold(
      backgroundColor: appColors.ranOutBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xSmall),
        child: _buildBody(context, productsNotifier, products),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProductsNotifier productsNotifier,
    List<ProductModel> products,
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
        child: Text(
          'Yay Nothing is Out!',
          style: textTheme.bodyLarge!.copyWith(fontSize: 25),
        ),
      );
    }

    return ProductsList(products: products);
  }
}
