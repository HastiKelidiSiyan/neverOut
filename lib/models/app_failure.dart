sealed class AppFailure implements Exception {
  const AppFailure();
}

class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

class TimeoutFailure extends AppFailure {
  const TimeoutFailure();
}

class DuplicateProductFailure extends AppFailure {
  const DuplicateProductFailure();
}

class LocalDatabaseFailure extends AppFailure {
  const LocalDatabaseFailure();
}

class UnknownFailure extends AppFailure {
  const UnknownFailure();
}

String failureMessage(AppFailure failure) {
  return switch (failure) {
    NetworkFailure() =>
      'Couldn’t connect right now. Please check your internet connection.',
    TimeoutFailure() =>
      'The server took too long to respond. Please try again.',
    DuplicateProductFailure() =>
      'A product with this name already exists.',
    LocalDatabaseFailure() =>
      'We couldn’t save your change on this device. Please try again.',
    UnknownFailure() =>
      'Something went wrong. Please try again.',
  };
}