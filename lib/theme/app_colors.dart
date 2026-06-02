import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF808080);

  static const lightScaffold = Color(0xFAFAFAFA);
  static const lightTextMuted = Color(0xFA424242);
  static const lightBorder = Color(0xFAE0E0E0);
  static const lightStrongBorder = Color(0xFA2A2A2A);
  static const lightError = Color(0xFAD32F2F);
  static const lightErrorContainer = Color(0xFAFFCDD2);
  static const lightRanOutBackground = Color(0xFAFFEBEE);
  static const lightRanOutAppBar = Color.fromARGB(213, 255, 165, 165);
  static const lightInputLabel = Color(0xFA9E9E9E);
  static const lightSecondaryText = Color(0xFA757575);

  static const darkScaffold = Color(0xFA121212);
  static const darkSurface = Color(0xFA1E1E1E);
  static const darkRaisedSurface = Color(0xFA2A2A2A);
  static const darkRanOutSurface = Color(0xFA2A1A1A);
  static const darkRanOutBackground = Color(0xFA1A0F0F);
  static const darkRanOutBorder = Color(0xFA3D1F1F);
  static const darkTextMuted = Color(0xFAB0B0B0);
  static const darkInputLabel = Color(0xFA606060);
  static const darkError = Color(0xFAEF5350);
  static const darkNavUnselected = Color.fromARGB(168, 255, 255, 255);
}

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.appBarBackground,
    required this.ranOutAppBarBackground,
    required this.ranOutBackground,
    required this.productCardBackground,
    required this.lowProductCardBackground,
    required this.productBorder,
    required this.lowProductBorder,
    required this.quantityBadgeBackground,
    required this.lowQuantityBadgeBackground,
    required this.quantityText,
    required this.lowQuantityText,
    required this.secondaryButtonBackground,
    required this.secondaryButtonForeground,
    required this.secondaryButtonBorder,
    required this.inputLabel,
    required this.iconMuted,
  });

  final Color appBarBackground;
  final Color ranOutAppBarBackground;
  final Color ranOutBackground;
  final Color productCardBackground;
  final Color lowProductCardBackground;
  final Color productBorder;
  final Color lowProductBorder;
  final Color quantityBadgeBackground;
  final Color lowQuantityBadgeBackground;
  final Color quantityText;
  final Color lowQuantityText;
  final Color secondaryButtonBackground;
  final Color secondaryButtonForeground;
  final Color secondaryButtonBorder;
  final Color inputLabel;
  final Color iconMuted;

  static const light = AppThemeColors(
    appBarBackground: AppColors.white,
    ranOutAppBarBackground: AppColors.lightRanOutAppBar,
    ranOutBackground: AppColors.lightRanOutBackground,
    productCardBackground: AppColors.white,
    lowProductCardBackground: AppColors.white,
    productBorder: AppColors.lightBorder,
    lowProductBorder: AppColors.lightErrorContainer,
    quantityBadgeBackground: AppColors.lightBorder,
    lowQuantityBadgeBackground: AppColors.lightErrorContainer,
    quantityText: AppColors.lightTextMuted,
    lowQuantityText: AppColors.lightError,
    secondaryButtonBackground: AppColors.white,
    secondaryButtonForeground: AppColors.lightSecondaryText,
    secondaryButtonBorder: AppColors.lightBorder,
    inputLabel: AppColors.lightInputLabel,
    iconMuted: AppColors.grey,
  );

  static const dark = AppThemeColors(
    appBarBackground: AppColors.darkSurface,
    ranOutAppBarBackground: AppColors.darkRanOutSurface,
    ranOutBackground: AppColors.darkRanOutBackground,
    productCardBackground: AppColors.darkSurface,
    lowProductCardBackground: AppColors.darkRanOutSurface,
    productBorder: AppColors.darkRaisedSurface,
    lowProductBorder: AppColors.darkRanOutBorder,
    quantityBadgeBackground: AppColors.darkRaisedSurface,
    lowQuantityBadgeBackground: AppColors.darkRanOutBorder,
    quantityText: AppColors.darkTextMuted,
    lowQuantityText: AppColors.darkError,
    secondaryButtonBackground: AppColors.darkSurface,
    secondaryButtonForeground: AppColors.darkTextMuted,
    secondaryButtonBorder: AppColors.darkRaisedSurface,
    inputLabel: AppColors.darkInputLabel,
    iconMuted: AppColors.grey,
  );

  @override
  AppThemeColors copyWith({
    Color? appBarBackground,
    Color? ranOutAppBarBackground,
    Color? ranOutBackground,
    Color? productCardBackground,
    Color? lowProductCardBackground,
    Color? productBorder,
    Color? lowProductBorder,
    Color? quantityBadgeBackground,
    Color? lowQuantityBadgeBackground,
    Color? quantityText,
    Color? lowQuantityText,
    Color? secondaryButtonBackground,
    Color? secondaryButtonForeground,
    Color? secondaryButtonBorder,
    Color? inputLabel,
    Color? iconMuted,
  }) {
    return AppThemeColors(
      appBarBackground: appBarBackground ?? this.appBarBackground,
      ranOutAppBarBackground:
          ranOutAppBarBackground ?? this.ranOutAppBarBackground,
      ranOutBackground: ranOutBackground ?? this.ranOutBackground,
      productCardBackground:
          productCardBackground ?? this.productCardBackground,
      lowProductCardBackground:
          lowProductCardBackground ?? this.lowProductCardBackground,
      productBorder: productBorder ?? this.productBorder,
      lowProductBorder: lowProductBorder ?? this.lowProductBorder,
      quantityBadgeBackground:
          quantityBadgeBackground ?? this.quantityBadgeBackground,
      lowQuantityBadgeBackground:
          lowQuantityBadgeBackground ?? this.lowQuantityBadgeBackground,
      quantityText: quantityText ?? this.quantityText,
      lowQuantityText: lowQuantityText ?? this.lowQuantityText,
      secondaryButtonBackground:
          secondaryButtonBackground ?? this.secondaryButtonBackground,
      secondaryButtonForeground:
          secondaryButtonForeground ?? this.secondaryButtonForeground,
      secondaryButtonBorder:
          secondaryButtonBorder ?? this.secondaryButtonBorder,
      inputLabel: inputLabel ?? this.inputLabel,
      iconMuted: iconMuted ?? this.iconMuted,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      appBarBackground:
          Color.lerp(appBarBackground, other.appBarBackground, t)!,
      ranOutAppBarBackground:
          Color.lerp(ranOutAppBarBackground, other.ranOutAppBarBackground, t)!,
      ranOutBackground:
          Color.lerp(ranOutBackground, other.ranOutBackground, t)!,
      productCardBackground:
          Color.lerp(productCardBackground, other.productCardBackground, t)!,
      lowProductCardBackground: Color.lerp(
        lowProductCardBackground,
        other.lowProductCardBackground,
        t,
      )!,
      productBorder: Color.lerp(productBorder, other.productBorder, t)!,
      lowProductBorder:
          Color.lerp(lowProductBorder, other.lowProductBorder, t)!,
      quantityBadgeBackground: Color.lerp(
        quantityBadgeBackground,
        other.quantityBadgeBackground,
        t,
      )!,
      lowQuantityBadgeBackground: Color.lerp(
        lowQuantityBadgeBackground,
        other.lowQuantityBadgeBackground,
        t,
      )!,
      quantityText: Color.lerp(quantityText, other.quantityText, t)!,
      lowQuantityText:
          Color.lerp(lowQuantityText, other.lowQuantityText, t)!,
      secondaryButtonBackground: Color.lerp(
        secondaryButtonBackground,
        other.secondaryButtonBackground,
        t,
      )!,
      secondaryButtonForeground: Color.lerp(
        secondaryButtonForeground,
        other.secondaryButtonForeground,
        t,
      )!,
      secondaryButtonBorder:
          Color.lerp(secondaryButtonBorder, other.secondaryButtonBorder, t)!,
      inputLabel: Color.lerp(inputLabel, other.inputLabel, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
    );
  }
}
