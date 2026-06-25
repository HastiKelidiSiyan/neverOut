import 'package:flutter/material.dart';

class IconCategoryItem extends StatelessWidget {
  const IconCategoryItem({super.key, required this.iconData});

  final IconData iconData;

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
        child: Icon(iconData),
      ),
    );
  }
}
