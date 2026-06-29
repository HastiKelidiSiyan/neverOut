import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:never_out/theme/app_colors.dart';
import 'package:never_out/theme/app_constants.dart';

class IconCategoryItem extends StatelessWidget {
  const IconCategoryItem({
    super.key,
    required this.iconData,
    required this.onIconSelect,
    required this.isSelected,
  });

  final FaIconData iconData;
  final void Function(FaIconData iconData) onIconSelect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppThemeColors>()!;
    final colorScheme = theme.colorScheme;
    final backgroundColor = isSelected
        ? colorScheme.primary
        : appColors.secondaryButtonBackground;
    final borderColor = isSelected
        ? colorScheme.primary
        : appColors.secondaryButtonBorder;
    final iconColor = isSelected ? colorScheme.onPrimary : appColors.iconMuted;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.small),
      onTap: () {
        onIconSelect(iconData);
      },
      child: AnimatedContainer(
        duration: AppDurations.short,
        curve: Curves.easeOut,
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppBorderWidths.regular
                : AppBorderWidths.thin,
          ),
        ),
        child: Center(
          child: FaIcon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
