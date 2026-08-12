import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/config/app_flavor.dart';
import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/crashlytics/crashlytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_pay_app/main.dart' as app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Initialize Firebase according to the current flavor
  await Firebase.initializeApp(
    options: FlavorConfig.firebaseOptions,
  );

  // Load environment file according to the current flavor
  await dotenv.load(
    fileName: FlavorConfig.envFile,
  );

  // Initialize dependencies
  await setupDependencies();
  final crashlytics = getIt<CrashlyticsService>();

  // Report Flutter framework errors to Crashlytics
  FlutterError.onError = (errorDetails) {
    crashlytics.recordFlutterError(
      errorDetails,
      fatal: true,
    );
  };

  // Report uncaught asynchronous errors to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    crashlytics.recordError(
      error,
      stack,
      fatal: true,
    );

    return true;
  };

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      path: 'assets/translations',
      child: const app.MyApp(),
    ),
  );
}