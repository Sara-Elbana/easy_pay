import 'package:firebase_core/firebase_core.dart';

import '../core/config/app_flavor.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_uat.dart' as uat;
import 'firebase_options_prod.dart' as prod;

Future<void> initializeFirebase() async {
  switch (FlavorConfig.flavor) {
    case AppFlavor.dev:
      await Firebase.initializeApp(
        options: dev.DefaultFirebaseOptions.currentPlatform,
      );
      break;

    case AppFlavor.uat:
      await Firebase.initializeApp(
        options: uat.DefaultFirebaseOptions.currentPlatform,
      );
      break;

    case AppFlavor.prod:
      await Firebase.initializeApp(
        options: prod.DefaultFirebaseOptions.currentPlatform,
      );
      break;
  }
}