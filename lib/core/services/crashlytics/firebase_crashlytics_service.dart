import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'crashlytics_service.dart';

class FirebaseCrashlyticsService implements CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;

  FirebaseCrashlyticsService({
    FirebaseCrashlytics? crashlytics,
  }) : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  @override
  Future<void> recordError(
      Object error,
      StackTrace stack, {
        bool fatal = false,
        String? reason,
      }) async {
    await _crashlytics.recordError(
      error,
      stack,
      fatal: fatal,
      reason: reason,
    );
  }

  @override
  Future<void> recordFlutterError(
      FlutterErrorDetails errorDetails, {
        bool fatal = false,
      }) async {
    if (fatal) {
      await _crashlytics.recordFlutterFatalError(errorDetails);
    } else {
      await _crashlytics.recordFlutterError(errorDetails);
    }
  }

  @override
  Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  @override
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }
}