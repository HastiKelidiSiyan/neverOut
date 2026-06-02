import 'package:flutter/material.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_component_styles.dart';
import 'package:never_out/theme/app_text_styles.dart';

ThemeData buildDarkTheme() {
  final baseTheme = ThemeData.dark();

  return baseTheme.copyWith(
    brightness: Brightness.dark,
    colorScheme: baseTheme.colorScheme.copyWith(
      brightness: Brightness.dark,
      primary: AppColors.white,
      onPrimary: AppColors.black,
      surface: AppColors.darkSurface,
      onSurface: AppColors.white,
      error: AppColors.darkError,
    ),
    scaffoldBackgroundColor: AppColors.darkScaffold,
    appBarTheme: baseTheme.appBarTheme.copyWith(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonStyles.primaryElevatedButtonStyle(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      shape: CircleBorder(),
    ),
    textTheme: buildAppTextTheme(
      baseTextTheme: baseTheme.textTheme,
      primaryTextColor: AppColors.white,
      secondaryTextColor: AppColors.darkTextMuted,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: AppSegmentedButtonStyles.segmentedButtonStyle(
        selectedBackgroundColor: AppColors.white,
        unselectedBackgroundColor: AppColors.darkSurface,
        selectedForegroundColor: AppColors.black,
        unselectedForegroundColor: AppColors.white,
        selectedBorderColor: AppColors.white,
        unselectedBorderColor: AppColors.darkRaisedSurface,
      ),
    ),
    inputDecorationTheme: AppInputStyles.inputDecorationTheme(
      fillColor: AppColors.darkSurface,
      enabledBorderColor: AppColors.lightBorder,
      focusedBorderColor: AppColors.white,
      errorBorderColor: AppColors.darkError,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      unselectedItemColor: AppColors.darkNavUnselected,
      selectedItemColor: AppColors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    extensions: const <ThemeExtension<dynamic>>[
      AppThemeColors.dark,
    ],
  );
}
