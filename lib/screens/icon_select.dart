import 'package:flutter/material.dart';
import 'package:never_out/data/categories.dart';
import 'package:never_out/widgets/icon_category.dart';

class IconSelectScreen extends StatefulWidget {
  const IconSelectScreen({super.key});

  @override
  State<IconSelectScreen> createState() => _IconSelectScreenState();
}

class _IconSelectScreenState extends State<IconSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select an Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: Categories.all.length,
          itemBuilder: (context, index) {
            return IconCategory(category: Categories.all[index]);
          },
        ),
      ),
    );
  }
}
