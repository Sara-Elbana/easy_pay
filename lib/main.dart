import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/config/app_flavor.dart';
import 'package:easy_pay_app/core/routes/app_route.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Initialize Firebase according to the current flavor
  await Firebase.initializeApp(
    options: FlavorConfig.firebaseOptions,
  );

  await dotenv.load(
    fileName: FlavorConfig.envFile,
  );

  // Initialize dependencies
  await setupDependencies();


  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Pay',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRoutesName.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
