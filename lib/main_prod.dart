import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_pay_app/main.dart' as app;

Future<void> main() async {
  await dotenv.load(fileName: '.env.prod');
  app.main();
}