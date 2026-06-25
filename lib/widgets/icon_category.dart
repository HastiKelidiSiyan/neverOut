import 'package:flutter/material.dart';
import 'package:never_out/models/category_model.dart';
import 'package:never_out/widgets/icon_category_item.dart';

class IconCategory extends StatelessWidget {
  const IconCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.name),
          SizedBox(
            height: 6,
          ),
          GridView.count(
            crossAxisCount: 8,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final iconData in category.icons)
                IconCategoryItem(iconData: iconData),
            ],
          ),
        ],
      ),
    );
  }
}
