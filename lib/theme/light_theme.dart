import 'package:flutter/material.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_component_styles.dart';
import 'package:never_out/theme/app_text_styles.dart';

ThemeData buildLightTheme() {
  final baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    brightness: Brightness.light,
    colorScheme: baseTheme.colorScheme.copyWith(
      brightness: Brightness.light,
      primary: AppColors.black,
      onPrimary: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
      error: AppColors.lightError,
    ),
    scaffoldBackgroundColor: AppColors.lightScaffold,
    appBarTheme: baseTheme.appBarTheme.copyWith(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonStyles.primaryElevatedButtonStyle(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      shape: CircleBorder(),
    ),
    textTheme: buildAppTextTheme(
      baseTextTheme: baseTheme.textTheme,
      primaryTextColor: AppColors.black,
      secondaryTextColor: AppColors.lightTextMuted,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: AppSegmentedButtonStyles.segmentedButtonStyle(
        selectedBackgroundColor: AppColors.black,
        unselectedBackgroundColor: AppColors.white,
        selectedForegroundColor: AppColors.white,
        unselectedForegroundColor: AppColors.black,
        selectedBorderColor: AppColors.black,
        unselectedBorderColor: AppColors.lightBorder,
      ),
    ),
    inputDecorationTheme: AppInputStyles.inputDecorationTheme(
      fillColor: AppColors.white,
      enabledBorderColor: AppColors.lightStrongBorder,
      focusedBorderColor: AppColors.black,
      errorBorderColor: AppColors.lightError,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      unselectedItemColor: AppColors.lightSecondaryText,
      selectedItemColor: AppColors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),
    extensions: const <ThemeExtension<dynamic>>[
      AppThemeColors.light,
    ],
  );
}
