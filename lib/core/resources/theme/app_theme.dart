import 'package:air_guard/core/resources/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:air_guard/core/resources/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.brand.primary,
      onPrimary: Colors.white,
      secondary: AppColors.brand.secondary,
      onSecondary: Colors.white,
      error: AppColors.feedback.error,
      onError: Colors.white,
      background: AppColors.background.lightMain,
      onBackground: AppColors.textColor.lightPrimary,
      surface: AppColors.background.cardLight,
      onSurface: AppColors.textColor.lightPrimary,
      surfaceTint: AppColors.brand.primary,
    ),
    scaffoldBackgroundColor: AppColors.background.lightMain,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background.lightMain,
      foregroundColor: AppColors.textColor.lightPrimary,
      elevation: 0,
      titleTextStyle: appTextTheme.titleLarge,
      iconTheme: IconThemeData(color: AppColors.textColor.lightPrimary),
    ),
    cardTheme: CardTheme(
      color: AppColors.background.cardLight,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brand.primary,
        foregroundColor: Colors.white,
        textStyle: appTextTheme.buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brand.primary,
        side: BorderSide(color: AppColors.brand.primary),
        textStyle:
            appTextTheme.buttonText?.copyWith(color: AppColors.brand.primary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.background.cardLight,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.ui.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.ui.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.brand.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.feedback.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.feedback.error, width: 2),
      ),
      labelStyle: appTextTheme.bodyMedium,
      hintStyle:
          appTextTheme.bodyMedium?.copyWith(color: AppColors.textColor.hint),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brand.secondary;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brand.secondary.withOpacity(0.5);
        }
        return null;
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background.cardLight,
      selectedItemColor: AppColors.brand.primary,
      unselectedItemColor: AppColors.textColor.lightSecondary,
      selectedLabelStyle: appTextTheme.labelSmall,
      unselectedLabelStyle: appTextTheme.labelSmall,
    ),
    textTheme: TextTheme(
      displayLarge: appTextTheme.displayLarge,
      displayMedium: appTextTheme.displayMedium,
      displaySmall: appTextTheme.displaySmall,
      headlineLarge: appTextTheme.headlineLarge,
      headlineMedium: appTextTheme.headlineMedium,
      headlineSmall: appTextTheme.headlineSmall,
      titleLarge: appTextTheme.titleLarge,
      titleMedium: appTextTheme.titleMedium,
      titleSmall: appTextTheme.titleSmall,
      bodyLarge: appTextTheme.bodyLarge,
      bodyMedium: appTextTheme.bodyMedium,
      bodySmall: appTextTheme.bodySmall,
      labelLarge: appTextTheme.labelLarge,
      labelMedium: appTextTheme.labelMedium,
      labelSmall: appTextTheme.labelSmall,
    ),
    extensions: [extendedTextTheme],
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.brand.primary,
      onPrimary: Colors.white,
      secondary: AppColors.brand.secondary,
      onSecondary: Colors.white,
      error: AppColors.feedback.error,
      onError: Colors.white,
      background: AppColors.background.darkMain,
      onBackground: AppColors.textColor.darkPrimary,
      surface: AppColors.background.cardDark,
      onSurface: AppColors.textColor.darkPrimary,
      surfaceTint: AppColors.brand.primary,
    ),
    scaffoldBackgroundColor: AppColors.background.darkMain,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background.darkMain,
      foregroundColor: AppColors.textColor.darkPrimary,
      elevation: 0,
      titleTextStyle: appTextTheme.titleLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      iconTheme: IconThemeData(color: AppColors.textColor.darkPrimary),
    ),
    cardTheme: CardTheme(
      color: AppColors.background.cardDark,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brand.primaryDark,
        foregroundColor: Colors.white,
        textStyle: appTextTheme.buttonText,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brand.primary,
        side: BorderSide(color: AppColors.brand.primary),
        textStyle:
            appTextTheme.buttonText?.copyWith(color: AppColors.brand.primary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.background.cardDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.ui.border.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.ui.border.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.brand.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.feedback.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.feedback.error, width: 2),
      ),
      labelStyle: appTextTheme.bodyMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      hintStyle: appTextTheme.bodyMedium
          ?.copyWith(color: AppColors.textColor.darkSecondary),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brand.secondary;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.brand.secondary.withOpacity(0.5);
        }
        return null;
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background.cardDark,
      selectedItemColor: AppColors.brand.primary,
      unselectedItemColor: AppColors.textColor.darkSecondary,
      selectedLabelStyle: appTextTheme.labelSmall
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      unselectedLabelStyle: appTextTheme.labelSmall
          ?.copyWith(color: AppColors.textColor.darkSecondary),
    ),
    textTheme: TextTheme(
      displayLarge: appTextTheme.displayLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      displayMedium: appTextTheme.displayMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      displaySmall: appTextTheme.displaySmall
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      headlineLarge: appTextTheme.headlineLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      headlineMedium: appTextTheme.headlineMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      headlineSmall: appTextTheme.headlineSmall
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      titleLarge: appTextTheme.titleLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      titleMedium: appTextTheme.titleMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      titleSmall: appTextTheme.titleSmall
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      bodyLarge: appTextTheme.bodyLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      bodyMedium: appTextTheme.bodyMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      bodySmall: appTextTheme.bodySmall
          ?.copyWith(color: AppColors.textColor.darkSecondary),
      labelLarge: appTextTheme.labelLarge
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      labelMedium: appTextTheme.labelMedium
          ?.copyWith(color: AppColors.textColor.darkPrimary),
      labelSmall: appTextTheme.labelSmall
          ?.copyWith(color: AppColors.textColor.darkPrimary),
    ),
    extensions: [
      extendedTextTheme.copyWith(
        quizTitle: appTextTheme.quizTitle
            ?.copyWith(color: AppColors.textColor.darkPrimary),
        quizQuestion: appTextTheme.quizQuestion
            ?.copyWith(color: AppColors.textColor.darkPrimary),
        quizAnswer: appTextTheme.quizAnswer
            ?.copyWith(color: AppColors.textColor.darkPrimary),
        quizExplanation: appTextTheme.quizExplanation
            ?.copyWith(color: AppColors.textColor.darkSecondary),
        scoreText:
            appTextTheme.scoreText?.copyWith(color: AppColors.brand.primary),
        timerText:
            appTextTheme.timerText?.copyWith(color: AppColors.accent.orange),
        statisticsValue: appTextTheme.statisticsValue
            ?.copyWith(color: AppColors.textColor.darkPrimary),
        statisticsLabel: appTextTheme.statisticsLabel
            ?.copyWith(color: AppColors.textColor.darkSecondary),
        chartLabel: appTextTheme.chartLabel
            ?.copyWith(color: AppColors.textColor.darkSecondary),
      ),
    ],
  );
}
