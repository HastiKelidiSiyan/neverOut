import 'package:flutter/material.dart';
import 'package:never_out/models/app_failure.dart';

class AppFeedback {
  static void showFailure(BuildContext context, AppFailure failure) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 124, 39, 39),
        content: Text(
          style: TextStyle(color: Colors.red),
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

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: result
            ? const Color.fromARGB(255, 46, 105, 48)
            : const Color.fromARGB(255, 124, 39, 39),
        content: Text(
          style: TextStyle(color: result ? Colors.green : Colors.red),
          result
              ? 'Sync completed successfully.'
              : 'Sync failed. Please check your connection, and try again. ${failure != null ? failureMessage(failure) : ''}',
        ),
      ),
    );
  }
}
