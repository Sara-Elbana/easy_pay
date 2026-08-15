import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;

  CrashlyticsService({
    FirebaseCrashlytics? crashlytics,
  }) : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  Future<void> clearUserIdentifier() async {
    await _crashlytics.setUserIdentifier('');
  }
}
