import 'package:flutter/material.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/widget/theme/app_color_theme_extension.dart';
import 'package:quick_flutter/widget/theme/app_text_theme_extension.dart';

class AppTheme {
  static final light = () {
    final defaultTheme = ThemeData.light();

    final colorExt = AppColorsExtension(
      textDefault: const Color(0xff1F1F1F),
      textSubtle: const Color(0xff5C5C5C),
      textDisabled: const Color(0xff9E9E9E),
      textDanger: const Color(0xffC20B2A),
      textSuccess: const Color(0xff218011),
      backgroundDefault: const Color(0xffFBFBFB),
      backgroundSubtle: const Color(0xffF4F4F4),
      backgroundPrimaryContainer: const Color(0xffF6EDFF),
      backgroundPrimaryActionEnabled: const Color(0xff4F378B),
      backgroundPrimaryActionDisabled: const Color(0xff21005D),
      backgroundPrimaryActionHovered: const Color(0xff381E72),
    );

    return defaultTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.seed,
        outline: AppColor.outline,
        outlineVariant: AppColor.outlineVariant,
        shadow: AppColor.shadow,
      ),
      extensions: [
        colorExt,
        AppTextThemeExtension(
          displayLarge: TextStyle(fontSize: 57, color: colorExt.textDefault),
          displayMedium: TextStyle(fontSize: 45, color: colorExt.textDefault),
          displaySmall: TextStyle(fontSize: 36, color: colorExt.textDefault),
          headlineLarge: TextStyle(fontSize: 32, color: colorExt.textDefault),
          headlineMedium: TextStyle(fontSize: 28, color: colorExt.textDefault),
          headlineSmall: TextStyle(fontSize: 24, color: colorExt.textDefault),
          titleLarge: TextStyle(fontSize: 22, color: colorExt.textDefault),
          titleMedium: TextStyle(fontSize: 16, color: colorExt.textDefault),
          titleSmall: TextStyle(fontSize: 14, color: colorExt.textDefault),
          bodyLarge: TextStyle(fontSize: 16, color: colorExt.textDefault),
          bodyMedium: TextStyle(fontSize: 14, color: colorExt.textDefault),
          bodySmall: TextStyle(fontSize: 12, color: colorExt.textDefault),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
          labelMidium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
        ),
      ],
    );
  }();

  static final dark = () {
    final defaultTheme = ThemeData.dark();

    final colorExt = AppColorsExtension(
      textDefault: Colors.white,
      textSubtle: const Color(0xff5C5C5C),
      textDisabled: const Color(0xff9E9E9E),
      textDanger: const Color(0xffC20B2A),
      textSuccess: const Color(0xff218011),
      backgroundDefault: const Color(0xffFBFBFB),
      backgroundSubtle: const Color(0xffF4F4F4),
      backgroundPrimaryContainer: const Color(0xffF6EDFF),
      backgroundPrimaryActionEnabled: const Color(0xff4F378B),
      backgroundPrimaryActionDisabled: const Color(0xff21005D),
      backgroundPrimaryActionHovered: const Color(0xff381E72),
    );

    return defaultTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.seed,
        outline: AppColor.outline,
        outlineVariant: AppColor.outlineVariant,
        shadow: AppColor.shadow,
      ),
      extensions: [
        colorExt,
        AppTextThemeExtension(
          displayLarge: TextStyle(fontSize: 57, color: colorExt.textDefault),
          displayMedium: TextStyle(fontSize: 45, color: colorExt.textDefault),
          displaySmall: TextStyle(fontSize: 36, color: colorExt.textDefault),
          headlineLarge: TextStyle(fontSize: 32, color: colorExt.textDefault),
          headlineMedium: TextStyle(fontSize: 28, color: colorExt.textDefault),
          headlineSmall: TextStyle(fontSize: 24, color: colorExt.textDefault),
          titleLarge: TextStyle(fontSize: 22, color: colorExt.textDefault),
          titleMedium: TextStyle(fontSize: 16, color: colorExt.textDefault),
          titleSmall: TextStyle(fontSize: 14, color: colorExt.textDefault),
          bodyLarge: TextStyle(fontSize: 16, color: colorExt.textDefault),
          bodyMedium: TextStyle(fontSize: 14, color: colorExt.textDefault),
          bodySmall: TextStyle(fontSize: 12, color: colorExt.textDefault),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
          labelMidium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorExt.textDefault,
          ),
        ),
      ],
    );
  }();
}

extension AppThemeExtension on BuildContext {
  AppTextThemeExtension get appTextTheme {
    return Theme.of(this).extension<AppTextThemeExtension>()!;
  }

  AppColorsExtension get appColors {
    return Theme.of(this).extension<AppColorsExtension>()!;
  }
}
