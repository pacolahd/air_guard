import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  const AppTextTheme({
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
    this.quizTitle,
    this.quizQuestion,
    this.quizAnswer,
    this.quizExplanation,
    this.scoreText,
    this.timerText,
    this.buttonText,
    this.statisticsValue,
    this.statisticsLabel,
    this.chartLabel,
  });

  final TextStyle? displayLarge;
  final TextStyle? displayMedium;
  final TextStyle? displaySmall;
  final TextStyle? headlineLarge;
  final TextStyle? headlineMedium;
  final TextStyle? headlineSmall;
  final TextStyle? titleLarge;
  final TextStyle? titleMedium;
  final TextStyle? titleSmall;
  final TextStyle? bodyLarge;
  final TextStyle? bodyMedium;
  final TextStyle? bodySmall;
  final TextStyle? labelLarge;
  final TextStyle? labelMedium;
  final TextStyle? labelSmall;
  final TextStyle? quizTitle;
  final TextStyle? quizQuestion;
  final TextStyle? quizAnswer;
  final TextStyle? quizExplanation;
  final TextStyle? scoreText;
  final TextStyle? timerText;
  final TextStyle? buttonText;
  final TextStyle? statisticsValue;
  final TextStyle? statisticsLabel;
  final TextStyle? chartLabel;

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? quizTitle,
    TextStyle? quizQuestion,
    TextStyle? quizAnswer,
    TextStyle? quizExplanation,
    TextStyle? scoreText,
    TextStyle? timerText,
    TextStyle? buttonText,
    TextStyle? statisticsValue,
    TextStyle? statisticsLabel,
    TextStyle? chartLabel,
  }) {
    return AppTextTheme(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      quizTitle: quizTitle ?? this.quizTitle,
      quizQuestion: quizQuestion ?? this.quizQuestion,
      quizAnswer: quizAnswer ?? this.quizAnswer,
      quizExplanation: quizExplanation ?? this.quizExplanation,
      scoreText: scoreText ?? this.scoreText,
      timerText: timerText ?? this.timerText,
      buttonText: buttonText ?? this.buttonText,
      statisticsValue: statisticsValue ?? this.statisticsValue,
      statisticsLabel: statisticsLabel ?? this.statisticsLabel,
      chartLabel: chartLabel ?? this.chartLabel,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }
    return AppTextTheme(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t),
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t),
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t),
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t),
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t),
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t),
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t),
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t),
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t),
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t),
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t),
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t),
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t),
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t),
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t),
      quizTitle: TextStyle.lerp(quizTitle, other.quizTitle, t),
      quizQuestion: TextStyle.lerp(quizQuestion, other.quizQuestion, t),
      quizAnswer: TextStyle.lerp(quizAnswer, other.quizAnswer, t),
      quizExplanation:
          TextStyle.lerp(quizExplanation, other.quizExplanation, t),
      scoreText: TextStyle.lerp(scoreText, other.scoreText, t),
      timerText: TextStyle.lerp(timerText, other.timerText, t),
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t),
      statisticsValue:
          TextStyle.lerp(statisticsValue, other.statisticsValue, t),
      statisticsLabel:
          TextStyle.lerp(statisticsLabel, other.statisticsLabel, t),
      chartLabel: TextStyle.lerp(chartLabel, other.chartLabel, t),
    );
  }
}

final appTextTheme = AppTextTheme(
  displayLarge: GoogleFonts.roboto(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
    color: AppColors.textColor.lightPrimary,
  ),
  displayMedium: GoogleFonts.roboto(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
    color: AppColors.textColor.lightPrimary,
  ),
  displaySmall: GoogleFonts.roboto(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
    color: AppColors.textColor.lightPrimary,
  ),
  headlineLarge: GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
    color: AppColors.textColor.lightPrimary,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
    color: AppColors.textColor.lightPrimary,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
    color: AppColors.textColor.lightPrimary,
  ),
  titleLarge: GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.27,
    color: AppColors.textColor.lightPrimary,
  ),
  titleMedium: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    color: AppColors.textColor.lightPrimary,
  ),
  titleSmall: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textColor.lightPrimary,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: AppColors.textColor.lightPrimary,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: AppColors.textColor.lightPrimary,
  ),
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: AppColors.textColor.lightSecondary,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textColor.lightPrimary,
  ),
  labelMedium: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    color: AppColors.textColor.lightPrimary,
  ),
  labelSmall: GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    color: AppColors.textColor.lightPrimary,
  ),
);

final extendedTextTheme = AppTextTheme(
  quizTitle: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.33,
    color: AppColors.textColor.lightPrimary,
  ),
  quizQuestion: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    color: AppColors.textColor.lightPrimary,
  ),
  quizAnswer: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: AppColors.textColor.lightPrimary,
  ),
  quizExplanation: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: AppColors.textColor.lightSecondary,
    fontStyle: FontStyle.italic,
  ),
  scoreText: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.33,
    color: AppColors.brand.primary,
  ),
  timerText: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    color: AppColors.accent.orange,
  ),
  buttonText: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    height: 1.43,
    color: Colors.white,
  ),
  // statisticsValue: GoogleFonts.roboto(
  //   fontSize: 24,
  //   fontWeight: FontWeight.w700,
  //   letterSpacing: 0,
  //   height: 1.33,
  //   color: AppColors.textColor.lightPrimary,
  // ),
  // statisticsLabel: GoogleFonts.roboto(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w400,
  //   letterSpacing: 0.25,
  //   height: 1.43,
  //   color: AppColors.textColor.lightSecondary,
  // ),
  // chartLabel: GoogleFonts.roboto(
  //   fontSize: 12,
  //   fontWeight: FontWeight.w400,
  //   letterSpacing: 0.4,
  //   height: 1.33,
  //   color: AppColors.textColor.lightSecondary,
  // ),
);
