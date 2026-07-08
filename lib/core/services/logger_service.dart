import 'package:flutter/foundation.dart';

/// Global logger instance
final logger = AppLogger();

/// Simple logger service for debug logging
class AppLogger {
  void info(String message) {
    if (kDebugMode) {
      print('ℹ️ INFO: $message');
    }
  }

  void warning(String message) {
    if (kDebugMode) {
      print('⚠️ WARNING: $message');
    }
  }

  void error(String message) {
    if (kDebugMode) {
      print('❌ ERROR: $message');
    }
  }

  void debug(String message) {
    if (kDebugMode) {
      print('🐛 DEBUG: $message');
    }
  }

  void success(String message) {
    if (kDebugMode) {
      print('✅ SUCCESS: $message');
    }
  }
}
