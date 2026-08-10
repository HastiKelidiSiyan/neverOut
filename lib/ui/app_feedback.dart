import 'package:flutter/material.dart';
import 'package:never_out/models/app_failure.dart';

class AppFeedback {
  static void showFailure(BuildContext context, AppFailure failure) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(failureMessage(failure)),
      ),
    );
  }

  static void showSyncResult(BuildContext context, bool result) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          result
              ? 'Sync completed successfully.'
              : 'Sync failed. Please check your connection.',
        ),
      ),
    );
  }
}
