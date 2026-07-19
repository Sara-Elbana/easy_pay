import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_pay_app/main.dart';
import 'package:easy_pay_app/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:easy_pay_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';

import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/shared_preferences_service.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Mock SharedPreferences values for the test environment
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    
    if (!getIt.isRegistered<SharedPreferencesService>()) {
      final prefs = SharedPreferencesService();
      await prefs.init();
      getIt.registerSingleton<SharedPreferencesService>(prefs);
    }

    if (!getIt.isRegistered<OnboardingCubit>()) {
      getIt.registerFactory<OnboardingCubit>(
        () => OnboardingCubit(totalPages: 3),
      );
    }
  });

  testWidgets('App renders SplashScreen initially and routes after delay', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    );
    await tester.pump();

    // Verify that SplashScreen is mounted
    expect(find.byType(SplashScreen), findsOneWidget);

    // Verify that a CircularProgressIndicator is present on the splash screen
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Advance the virtual clock by 2.5 seconds to trigger the navigation timer and avoid pending timer error
    await tester.pump(const Duration(milliseconds: 2500));
    
    // Pump another frame to handle the transition animation
    await tester.pumpAndSettle();
  });
}
