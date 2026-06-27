import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCategoryItem extends StatefulWidget {
  const IconCategoryItem({super.key, required this.iconData});

  final FaIconData iconData;

  @override
  State<IconCategoryItem> createState() => _IconCategoryItemState();
}

class _IconCategoryItemState extends State<IconCategoryItem> {
  @override
    bool selected = false;
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        setState(() {
          selected = true;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.black : Colors.grey, width: selected ? 2 : 1),
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
