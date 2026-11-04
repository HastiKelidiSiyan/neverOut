import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/ui/app_feedback.dart';
import 'package:never_out/widgets/products_list.dart';

class RanOutScreen extends ConsumerWidget {
  const RanOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsNotifier = ref.read(productsProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = ref.watch(productsProvider).where((product) {
      return product.isLow;
    }).toList();

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkRanOutBackground
          : AppColors.lightRanOutBackground,
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
      AppFeedback.showFailure(context, productsNotifier.error!);
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
