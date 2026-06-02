import 'package:flutter/material.dart';
import 'package:never_out/models/product.dart';
import 'package:never_out/widgets/products_list_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductsListItem(
        product: products[index],
      ),
    );
  }
}
