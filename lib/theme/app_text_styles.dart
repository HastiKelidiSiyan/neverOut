import 'package:flutter/material.dart';

TextTheme buildAppTextTheme({
  required TextTheme baseTextTheme,
  required Color primaryTextColor,
  required Color secondaryTextColor,
}) {
  return baseTextTheme.copyWith(
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      color: primaryTextColor,
      fontSize: 24,
    ),
    titleMedium: baseTextTheme.titleMedium?.copyWith(
      color: primaryTextColor,
      fontSize: 14,
    ),
    titleSmall: baseTextTheme.titleSmall?.copyWith(
      color: secondaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(
      color: primaryTextColor,
    ),
  );
}
