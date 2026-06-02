import 'package:flutter/material.dart';
import 'package:never_out/theme/dark_theme.dart';
import 'package:never_out/theme/light_theme.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = buildLightTheme();
  static final ThemeData darkTheme = buildDarkTheme();
}
