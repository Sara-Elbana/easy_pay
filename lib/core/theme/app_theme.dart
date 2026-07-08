import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  /// Light theme configuration
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.accent,
        error: AppColors.error,
        errorContainer: AppColors.errorLight,
        surface: AppColors.white,
        onSurface: AppColors.gray900,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onTertiary: AppColors.black,
        onError: AppColors.white,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.gray50,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.white,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.gray900,
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          color: AppColors.gray900,
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          color: AppColors.gray900,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppColors.gray900,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.gray900,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.gray900,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.gray900),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          color: AppColors.gray900,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.gray700),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.gray800),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.gray700),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.gray600),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.gray900),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppColors.gray700,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.gray600),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTextStyles.hint,
        errorStyle: AppTextStyles.error,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.gray700,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.gray200),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.gray900,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.gray700,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: 1,
        space: 1,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.gray600,
        labelStyle: AppTextStyles.labelLarge,
        unselectedLabelStyle: AppTextStyles.labelLarge,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray900,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.gray200,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.white;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray400;
        }),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.gray300;
        }),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray500,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData darkTheme() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.accentDark,
        error: AppColors.errorLight,
        errorContainer: AppColors.errorDark,
        surface: AppColors.gray800,
        onSurface: AppColors.white,
        onPrimary: AppColors.black,
        onSecondary: AppColors.white,
        onTertiary: AppColors.white,
        onError: AppColors.black,
      ),
      scaffoldBackgroundColor: AppColors.gray900,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.gray900,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.white,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          color: AppColors.white,
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          color: AppColors.white,
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          color: AppColors.white,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppColors.white,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.white,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.white,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.white),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          color: AppColors.gray200,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.gray300),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.gray100),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.gray200),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.gray300),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          color: AppColors.gray200,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.gray300),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTextStyles.hint.copyWith(color: AppColors.gray200),
        errorStyle: AppTextStyles.error,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.gray200,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.black,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight),
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.gray800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.gray700),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.gray800,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.white,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.gray200,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.gray700,
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.gray800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primaryLight,
        unselectedLabelColor: AppColors.gray300,
        labelStyle: AppTextStyles.labelLarge,
        unselectedLabelStyle: AppTextStyles.labelLarge,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primaryLight, width: 2),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray100,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.gray900,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.gray700,
      ),
    );
  }
}
