import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCategoryItem extends StatefulWidget {
  const IconCategoryItem({
    super.key,
    required this.iconData,
    required this.onIconSelect,
    required this.isSelected,
  });

  final FaIconData iconData;
  final void Function(FaIconData iconData) onIconSelect;
  final bool isSelected;

  @override
  State<IconCategoryItem> createState() => _IconCategoryItemState();
}

class _IconCategoryItemState extends State<IconCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onIconSelect(widget.iconData);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected ? Colors.black : Colors.grey,
            width: widget.isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: FaIcon(
            color: Colors.black,
            widget.iconData,
          ),
        ),
      ),
    );
  }
}
