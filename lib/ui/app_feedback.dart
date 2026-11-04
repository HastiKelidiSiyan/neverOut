import 'package:flutter/material.dart';
import 'package:never_out/models/app_failure.dart';
import 'package:never_out/theme/app_colors.dart';

class AppFeedback {
  static void showFailure(BuildContext context, AppFailure failure) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: isDark
            ? AppColors.darkErrorContainer
            : AppColors.lightErrorContainer,
        content: Text(
          style: TextStyle(
            color: isDark ? AppColors.darkError : AppColors.lightError,
          ),
          failureMessage(failure),
        ),
      ),
    );
  }

  static void showSyncResult(
    BuildContext context,
    bool result,
    AppFailure? failure,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: result
            ? (isDark
                  ? AppColors.darkSuccessContainer
                  : AppColors.lightSuccessContainer)
            : (isDark
                  ? AppColors.darkErrorContainer
                  : AppColors.lightErrorContainer),
        content: Text(
          style: TextStyle(
            color: result
                ? (isDark ? AppColors.darkSuccess : AppColors.lightSuccess)
                : (isDark ? AppColors.darkError : AppColors.lightError),
          ),
          result
              ? 'Sync completed successfully.'
              : 'Sync failed. Please check your connection, and try again. ${failure != null ? failureMessage(failure) : ''}',
        ),
      ),
    );
  }
}
