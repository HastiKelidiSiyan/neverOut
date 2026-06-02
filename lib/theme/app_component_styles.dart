import 'package:flutter/material.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';

class AppInputStyles {
  const AppInputStyles._();

  static InputDecorationTheme inputDecorationTheme({
    required Color fillColor,
    required Color enabledBorderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      enabledBorder: outlineInputBorder(enabledBorderColor),
      focusedBorder: outlineInputBorder(focusedBorderColor),
      errorBorder: outlineInputBorder(errorBorderColor),
    );
  }

  static OutlineInputBorder outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: AppBorderWidths.regular,
        color: color,
      ),
      borderRadius: BorderRadius.circular(AppRadius.medium),
    );
  }
}

class AppButtonStyles {
  const AppButtonStyles._();

  static ButtonStyle primaryElevatedButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        side: const BorderSide(width: AppBorderWidths.regular),
      ),
      disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
    );
  }

  static ButtonStyle circularIconButtonStyle() {
    return ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      fixedSize: const Size.square(AppSizes.quantityButton),
    );
  }

  static ButtonStyle secondaryElevatedButtonStyle(
    AppThemeColors colors, {
    Size? fixedSize,
  }) {
    return ElevatedButton.styleFrom(
      fixedSize: fixedSize,
      backgroundColor: colors.secondaryButtonBackground,
      foregroundColor: colors.secondaryButtonForeground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        side: BorderSide(color: colors.secondaryButtonBorder),
      ),
    );
  }
}

class AppSegmentedButtonStyles {
  const AppSegmentedButtonStyles._();

  static ButtonStyle segmentedButtonStyle({
    required Color selectedBackgroundColor,
    required Color unselectedBackgroundColor,
    required Color selectedForegroundColor,
    required Color unselectedForegroundColor,
    required Color selectedBorderColor,
    required Color unselectedBorderColor,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return selectedBackgroundColor;
        }
        return unselectedBackgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return selectedForegroundColor;
        }
        return unselectedForegroundColor;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(
            color: selectedBorderColor,
            width: AppBorderWidths.regular,
          );
        }
        return BorderSide(
          color: unselectedBorderColor,
          width: AppBorderWidths.regular,
        );
      }),
    );
  }
}
