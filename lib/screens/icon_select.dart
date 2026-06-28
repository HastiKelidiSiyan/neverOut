import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/data/categories.dart';
import 'package:never_out/widgets/icon_category.dart';

class IconSelectScreen extends StatefulWidget {
  const IconSelectScreen({super.key});

  @override
  State<IconSelectScreen> createState() => _IconSelectScreenState();
}

class _IconSelectScreenState extends State<IconSelectScreen> {
  FaIconData selectedIcon = FontAwesomeIcons.boxOpen;

  void _selectIcon(FaIconData newSelectedIcon) {
    setState(() {
      selectedIcon = newSelectedIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, selectedIcon);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Select an Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: Categories.all.length,
          itemBuilder: (context, index) {
            return IconCategory(
              category: Categories.all[index],
              onIconSelect: _selectIcon,
              selectedIcon: selectedIcon,
            );
          },
        ),
      ),
    );
  }
}
