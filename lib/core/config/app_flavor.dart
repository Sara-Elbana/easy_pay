import 'package:easy_pay_app/firebase/firebase_options_dev.dart'
as dev_firebase;
import 'package:easy_pay_app/firebase/firebase_options_uat.dart'
as uat_firebase;
import 'package:easy_pay_app/firebase/firebase_options_prod.dart'
as prod_firebase;
import 'package:firebase_core/firebase_core.dart';

enum AppFlavor {
  dev,
  uat,
  prod,
}

class FlavorConfig {
  static const String _flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static AppFlavor get flavor {
    return AppFlavor.values.firstWhere(
          (flavor) => flavor.name == _flavor,
      orElse: () => AppFlavor.dev,
    );
  }

  static String get name => flavor.name;

  static String get envFile => '.env.$name';

  static FirebaseOptions get firebaseOptions {
    switch (flavor) {
      case AppFlavor.dev:
        return dev_firebase.DefaultFirebaseOptions.currentPlatform;

      case AppFlavor.uat:
        return uat_firebase.DefaultFirebaseOptions.currentPlatform;

      case AppFlavor.prod:
        return prod_firebase.DefaultFirebaseOptions.currentPlatform;
    }
  }
}