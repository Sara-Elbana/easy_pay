import 'package:easy_pay_app/core/routes/app_route.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutesName.signInScreen,
    );
  }
}


