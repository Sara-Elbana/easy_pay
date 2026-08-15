import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/config/app_config.dart';
import 'package:easy_pay_app/core/routes/app_route.dart';
import 'package:easy_pay_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';

/// Shared bootstrapping logic across all flavor entry points.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatformFor(config.environment),
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );

    return true;
  };
  await setupDependencies();
  //await dotenv.load(fileName: ".env");

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      path: 'assets/translations',
      child: MyApp(config: config),
    ),
  );
}

void main() async {
  await bootstrap(AppConfig.prod);
}

class MyApp extends StatelessWidget {
  final AppConfig config;

  const MyApp({
    super.key,
    this.config = AppConfig.prod,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRoutesName.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
