
import 'package:flutter/foundation.dart';

abstract class CrashlyticsService {
  Future<void> recordError(
      Object error,
      StackTrace stack, {
        bool fatal = false,
        String? reason,
      });

  Future<void> recordFlutterError(
      FlutterErrorDetails errorDetails, {
        bool fatal = false,
      });

  Future<void> setUserIdentifier(String userId);

  Future<void> setCustomKey(String key, Object value);

  Future<void> log(String message);
}