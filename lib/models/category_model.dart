import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final List<IconData> icons;

  const Category({
    required this.id,
    required this.name,
    required this.icons,
  });
}