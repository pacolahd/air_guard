import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const brand = _Brand();
  static const accent = _Accent();
  static const background = _Background();
  static const textColor = _TextColor();
  static const feedback = _Feedback();
  static const ui = _UI();
  static const overlay = _Overlay();
  static const shade = _Shade();

  static final MaterialColor primarySwatch =
      _createMaterialColor(brand.primary);
  static final MaterialColor secondarySwatch =
      _createMaterialColor(brand.secondary);

  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(
      amount >= 0 && amount <= 1,
      'Amount must be between 0 and 1',
    );
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(
      amount >= 0 && amount <= 1,
      'Amount must be between 0 and 1',
    );
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

class _Brand {
  const _Brand();

  List<Color> get gradient => [
        const Color(0xFFEDF8FF),
        const Color(0xFFFDC1E8),
        const Color(0xFFFFFFFF),
        const Color(0xFFFDFAE1),
      ];

  Color get primary =>
      const Color(0xFF2196F3); // Blue color for active elements
  Color get primaryLight => const Color(0xFF64B5F6);
  Color get primaryDark => const Color(0xFF1976D2);
  Color get secondary => const Color(0xFF4CAF50); // Green color for toggles
  Color get secondaryLight => const Color(0xFF81C784);
  Color get secondaryDark => const Color(0xFF388E3C);
}

class _Accent {
  const _Accent();

  Color get orange => const Color(0xFFFFA726);
  Color get purple => const Color(0xFF7E57C2);
  Color get red => const Color(0xFFEF5350);
}

class _Background {
  const _Background();

  // better background light: 0xFFE6F0FF
  Color get lightMain =>
      const Color(0xFFF0F4F8); // Light grayish-blue for light mode
  Color get darkMain => const Color(0xFF0A1929); // Dark blue for dark mode
  Color get cardLight => Colors.white;
  Color get cardDark =>
      const Color(0xFF132F4C); // Slightly lighter than the dark background
}

class _TextColor {
  const _TextColor();

  Color get lightPrimary => const Color(0xFF000000);
  Color get darkPrimary => Colors.white;
  Color get lightSecondary => const Color(0xFF666666);
  Color get darkSecondary => const Color(0xB3FFFFFF); // 70% white
  Color get hint => const Color(0xFF9E9E9E);
  Color get disabled => const Color(0xFFBDBDBD);
  Color get link => const Color(0xFF2196F3);
}

class _Feedback {
  const _Feedback();

  Color get success => const Color(0xFF4CAF50);
  Color get error => const Color(0xFFE57373);
  Color get warning => const Color(0xFFFFB74D);
  Color get info => const Color(0xFF64B5F6);
}

class _UI {
  const _UI();

  Color get divider => const Color(0xFFE0E0E0);
  Color get border => const Color(0xFFE0E0E0);
  Color get iconPrimary => const Color(0xFF757575);
  Color get iconSecondary => const Color(0xFF9E9E9E);
  Color get disabled => const Color(0xFFBDBDBD);
  Color get darkBlue => const Color(0xFF132F4C);
  Color get progressBar =>
      const Color(0xFF4CAF50); // Green color for progress bar
}

class _Overlay {
  const _Overlay();

  Color get light => const Color(0x0A000000);
  Color get dark => const Color(0x99000000);
}

class _Shade {
  const _Shade();

  Color get black05 => const Color(0x0D000000);
  Color get black12 => const Color(0x1F000000);
  Color get black26 => const Color(0x42000000);
  Color get black54 => const Color(0x8A000000);
  Color get black87 => const Color(0xDD000000);
  Color get white05 => const Color(0x0DFFFFFF);
  Color get white12 => const Color(0x1FFFFFFF);
  Color get white26 => const Color(0x42FFFFFF);
  Color get white54 => const Color(0x8AFFFFFF);
  Color get white87 => const Color(0xDDFFFFFF);
}
