import 'package:flutter/material.dart';

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
      body: Center(child: Text('Icon Select Screen', style: Theme.of(context).textTheme.titleLarge,)),
    );
  }
}
