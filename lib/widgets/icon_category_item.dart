import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCategoryItem extends StatelessWidget {
  const IconCategoryItem({super.key, required this.iconData});

  final FaIconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: FaIcon(iconData),
      ),
    );
  }
}
