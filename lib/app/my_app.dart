import 'package:flutter/material.dart';
import 'package:never_out/screens/tabs.dart';
import 'package:never_out/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Tabs(),
    );
  }
}
