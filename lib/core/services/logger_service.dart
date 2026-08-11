import 'package:flutter/foundation.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/crashlytics/crashlytics_service.dart';

final logger = AppLogger();

class AppLogger {
  CrashlyticsService? get _crashlytics {
    if (!getIt.isRegistered<CrashlyticsService>()) {
      return null;
    }

    return getIt<CrashlyticsService>();
  }

  void info(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ INFO: $message');
    }

    _crashlytics?.log('INFO: $message');
  }

  void warning(String message) {
    if (kDebugMode) {
      debugPrint('⚠️ WARNING: $message');
    }

    _crashlytics?.log('WARNING: $message');
  }

  void error(
      String message, {
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kDebugMode) {
      debugPrint('❌ ERROR: $message');
    }

    if (error != null && stackTrace != null) {
      _crashlytics?.recordError(
        error,
        stackTrace,
        fatal: false,
        reason: message,
      );
    } else {
      _crashlytics?.log('ERROR: $message');
    }
  }

  void debug(String message) {
    if (kDebugMode) {
      debugPrint('🐛 DEBUG: $message');
    }
  }

  void success(String message) {
    if (kDebugMode) {
      debugPrint('✅ SUCCESS: $message');
    }

    _crashlytics?.log('SUCCESS: $message');
  }
}