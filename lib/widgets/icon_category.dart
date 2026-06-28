import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/models/category_model.dart';
import 'package:never_out/widgets/icon_category_item.dart';

class IconCategory extends StatefulWidget {
  const IconCategory({
    super.key,
    required this.category,
    required this.onIconSelect,
    required this.selectedIcon
  });

  final Category category;
  final void Function(FaIconData iconData) onIconSelect;
  final FaIconData selectedIcon;

  @override
  State<IconCategory> createState() => _IconCategoryState();
}

class _IconCategoryState extends State<IconCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.category.name),
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
              for (final iconData in widget.category.icons)
                IconCategoryItem(
                  iconData: iconData,
                  isSelected: iconData == widget.selectedIcon ? true : false,
                  onIconSelect: widget.onIconSelect,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
