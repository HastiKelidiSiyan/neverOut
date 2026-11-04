import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/screens/new_product.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';
import 'package:never_out/ui/app_feedback.dart';

class ProductsListItem extends ConsumerWidget {
  const ProductsListItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  Color _borderColor(bool isDark) {
    if (product.isLow) {
      return isDark ? AppColors.darkRanOutBorder : AppColors.lightErrorContainer;
    }
    return isDark ? AppColors.darkRaisedSurface : AppColors.lightBorder;
  }

  Color _quantityColor(bool isDark) {
    if (product.isLow) {
      return isDark ? AppColors.darkRanOutBorder : AppColors.lightErrorContainer;
    }
    return isDark ? AppColors.darkRaisedSurface : AppColors.lightBorder;
  }

  Color _quantityTextColor(bool isDark) {
    if (product.isLow) {
      return isDark ? AppColors.darkError : AppColors.lightError;
    }
    return isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
  }

  Color _cardColor(bool isDark) {
    if (product.isLow) {
      return isDark ? AppColors.darkRanOutSurface : AppColors.white;
    }
    return isDark ? AppColors.darkSurface : AppColors.white;
  }

  String timeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays >= 365) {
      final years = difference.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      final months = difference.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: AppSizes.productListItemHeight,
      width: AppSizes.productListItemWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: () async {
            final navigator = Navigator.of(context);
            final productsNotifier = ref.read(productsProvider.notifier);

            final editedProduct = await navigator.push<ProductModel>(
              MaterialPageRoute(
                builder: (context) => NewProductScreen(
                  product: product,
                ),
              ),
            );

            if (editedProduct != null) {
              await productsNotifier.updateProduct(editedProduct);
              if (!context.mounted) return;

              if (productsNotifier.error != null) {
                AppFeedback.showFailure(context, productsNotifier.error!);
              }

              final result = await productsNotifier.syncProducts();
              if (!context.mounted) return;

              AppFeedback.showSyncResult(
                context,
                result,
                productsNotifier.error,
              );
            }
          },
          child: Dismissible(
            onDismissed: (direction) async {
              final productsNotifier = ref.read(productsProvider.notifier);
              await productsNotifier.deleteProduct(product);
              if (!context.mounted) return;

              if (productsNotifier.error != null) {
                AppFeedback.showFailure(context, productsNotifier.error!);
              }

              final result = await productsNotifier.syncProducts();
              if (!context.mounted) return;

              AppFeedback.showSyncResult(
                context,
                result,
                productsNotifier.error,
              );
            },
            key: ValueKey(product.databaseId),
            child: Card(
              elevation: 0,
              color: _cardColor(isDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.medium),
                side: BorderSide(
                  width: product.isLow
                      ? AppBorderWidths.regular
                      : AppBorderWidths.thin,
                  color: _borderColor(isDark),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: AppSpacing.large),
                  CircleAvatar(
                    backgroundColor: _quantityColor(isDark),
                    child: FaIcon(
                      product.iconData,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        'Updated ${timeAgo(product.updatedAt)}',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.large),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.small),
                        color: _quantityColor(isDark),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.medium,
                        vertical: AppSpacing.badgeVertical,
                      ),
                      child: Text(
                        '${product.quantity}  ${product.unitType.name[0].toUpperCase() + product.unitType.name.substring(1)}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: _quantityTextColor(isDark),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
