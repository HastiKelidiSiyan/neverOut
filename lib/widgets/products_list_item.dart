import 'package:flutter/material.dart';
import 'package:never_out/models/product.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/screens/new_product.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';

class ProductsListItem extends StatelessWidget {
  const ProductsListItem({
    super.key,
    required this.product,
  });

  final Product product;

  Color _borderColor(AppThemeColors colors) {
    return product.isLow ? colors.lowProductBorder : colors.productBorder;
  }

  Color _quantityColor(AppThemeColors colors) {
    return product.isLow
        ? colors.lowQuantityBadgeBackground
        : colors.quantityBadgeBackground;
  }

  Color _quantityTextColor(AppThemeColors colors) {
    return product.isLow ? colors.lowQuantityText : colors.quantityText;
  }

  Color _cardColor(AppThemeColors colors) {
    return product.isLow
        ? colors.lowProductCardBackground
        : colors.productCardBackground;
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;

    return SizedBox(
      height: AppSizes.productListItemHeight,
      width: AppSizes.productListItemWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: () async {
            final navigator = Navigator.of(context);
            final messenger = ScaffoldMessenger.of(context);
            final productsProvider = ProductsProviderScope.read(context);

            final editedProduct = await navigator.push<Product>(
              MaterialPageRoute(
                builder: (context) => NewProductScreen(
                  product: product,
                ),
              ),
            );

            if (editedProduct != null) {
              try {
                await productsProvider.updateProduct(editedProduct);
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            }
          },
          child: Dismissible(
            onDismissed: (direction) async {
              final messenger = ScaffoldMessenger.of(context);
              final productsProvider = ProductsProviderScope.read(context);
              try {
                await productsProvider.setDeleted(product);
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            },
            key: ValueKey(product.databaseId),
            child: Card(
              elevation: 0,
              color: _cardColor(appColors),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.medium),
                side: BorderSide(
                  width: product.isLow
                      ? AppBorderWidths.regular
                      : AppBorderWidths.thin,
                  color: _borderColor(appColors),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: AppSpacing.large),
                  CircleAvatar(
                    backgroundColor: _quantityColor(appColors),
                    child: Icon(
                      Icons.circle_rounded,
                      color: appColors.iconMuted,
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
                        'Updated ${timeAgo(product.updatedAt!)}',
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
                        color: _quantityColor(appColors),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.medium,
                        vertical: AppSpacing.badgeVertical,
                      ),
                      child: Text(
                        '${product.quantity}  ${product.unitType.name[0].toUpperCase() + product.unitType.name.substring(1)}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: _quantityTextColor(appColors),
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
