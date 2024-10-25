import 'package:air_guard/core/common/app/providers/tab_navigator.dart';
import 'package:air_guard/core/common/app/providers/user_provider.dart';
import 'package:air_guard/core/resources/theme/app_colors.dart';
import 'package:air_guard/core/resources/theme/app_text_theme.dart';
import 'package:air_guard/src/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

//Uncomment and adjust these lines when you have implemented user authentication
  UserProvider get userProvider => read<UserProvider>();
  UserEntity? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}

extension CustomThemeData on ThemeData {
  AppTextTheme get textStyles {
    return extension<AppTextTheme>()!;
  }

  AppColorsExtension get colors => AppColorsExtension(this);
}

class AppColorsExtension {
  final ThemeData _theme;

  AppColorsExtension(this._theme);

  Color get primary => AppColors.brand.primary;
  Color get primaryLight => AppColors.brand.primaryLight;
  Color get primaryDark => AppColors.brand.primaryDark;
  Color get secondary => AppColors.brand.secondary;
  Color get secondaryLight => AppColors.brand.secondaryLight;
  Color get secondaryDark => AppColors.brand.secondaryDark;

  Color get accentOrange => AppColors.accent.orange;
  Color get accentPurple => AppColors.accent.purple;
  Color get accentRed => AppColors.accent.red;

  Color get backgroundMain => _theme.brightness == Brightness.light
      ? AppColors.background.lightMain
      : AppColors.background.darkMain;
  Color get backgroundSurface => _theme.brightness == Brightness.light
      ? AppColors.background.cardLight
      : AppColors.background.cardDark;
  Color get backgroundCard => _theme.brightness == Brightness.light
      ? AppColors.background.cardLight
      : AppColors.background.cardDark;

  Color get textPrimary => _theme.brightness == Brightness.light
      ? AppColors.textColor.lightPrimary
      : AppColors.textColor.darkPrimary;
  Color get textSecondary => _theme.brightness == Brightness.light
      ? AppColors.textColor.lightSecondary
      : AppColors.textColor.darkSecondary;
  Color get textHint => AppColors.textColor.hint;
  Color get textDisabled => AppColors.textColor.disabled;
  Color get textLink => AppColors.textColor.link;

  Color get feedbackSuccess => AppColors.feedback.success;
  Color get feedbackError => AppColors.feedback.error;
  Color get feedbackWarning => AppColors.feedback.warning;
  Color get feedbackInfo => AppColors.feedback.info;

  Color get uiDivider => AppColors.ui.divider;
  Color get uiBorder => AppColors.ui.border;
  Color get uiIconPrimary => AppColors.ui.iconPrimary;
  Color get uiIconSecondary => AppColors.ui.iconSecondary;
  Color get uiDisabled => AppColors.ui.disabled;
  Color get uiProgressBar => AppColors.ui.progressBar;
  // Color get ui => AppColors.ui.darkBlue,

  Color get overlayLight => AppColors.overlay.light;
  Color get overlayDark => AppColors.overlay.dark;

  Color get shadeBlack05 => AppColors.shade.black05;
  Color get shadeBlack12 => AppColors.shade.black12;
  Color get shadeBlack26 => AppColors.shade.black26;
  Color get shadeBlack54 => AppColors.shade.black54;
  Color get shadeBlack87 => AppColors.shade.black87;
  Color get shadeWhite05 => AppColors.shade.white05;
  Color get shadeWhite12 => AppColors.shade.white12;
  Color get shadeWhite26 => AppColors.shade.white26;
  Color get shadeWhite54 => AppColors.shade.white54;
  Color get shadeWhite87 => AppColors.shade.white87;
}

String truncateString(String text, {int maxLength = 13}) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}
