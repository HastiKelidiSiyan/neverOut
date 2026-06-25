import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String id;
  final String name;
  final List<FaIconData> icons;

  const Category({
    required this.id,
    required this.name,
    required this.icons,
  });
}