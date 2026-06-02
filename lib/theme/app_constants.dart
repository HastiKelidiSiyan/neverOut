import 'package:flutter/material.dart';

class AppRadius {
  const AppRadius._();

  static const double small = 8;
  static const double medium = 12;
}

class AppSpacing {
  const AppSpacing._();

  static const double xSmall = 4;
  static const double badgeVertical = 6;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double xLarge = 20;
  static const double xxLarge = 40;
}

class AppBorderWidths {
  const AppBorderWidths._();

  static const double thin = 1;
  static const double regular = 2;
}

class AppDurations {
  const AppDurations._();

  static const Duration short = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
}

class AppSizes {
  const AppSizes._();

  static const double productListItemHeight = 64;
  static const double productListItemWidth = 335;
  static const double quantityButton = 56;
  static const double unitSelectorHeight = 50;
  static const double actionButtonHeight = 50;
  static const double primaryActionButtonWidth = 160;
  static const double secondaryActionButtonWidth = 120;
  static const double submitSpinner = 24;

  static const Size primaryActionButton = Size(
    primaryActionButtonWidth,
    actionButtonHeight,
  );
  static const Size secondaryActionButton = Size(
    secondaryActionButtonWidth,
    actionButtonHeight,
  );
}
