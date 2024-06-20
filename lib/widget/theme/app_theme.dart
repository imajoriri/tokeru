import 'package:flutter/material.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/widget/theme/app_color_theme_extension.dart';
import 'package:quick_flutter/widget/theme/app_spacing_theme_extension.dart';
import 'package:quick_flutter/widget/theme/app_text_theme_extension.dart';

class AppTheme {
  static final spacing = () {
    return AppSpacingExtension(
      none: 0,
      smallX: 4,
      small: 8,
      medium: 16,
      large: 24,
    );
  }();

  static final color = () {
    return AppColorsExtension(
      primary: const Color(0xff4DB0FF),
      primaryHovered: const Color(0xff4DB0FF).withOpacity(0.8),
      primaryContainer: Colors.white,
      textDefault: const Color(0xff1F1F1F),
      textSubtle: const Color(0xff5C5C5C),
      textDisabled: const Color(0xff9E9E9E),
      textDanger: const Color(0xffC20B2A),
      textSuccess: const Color(0xff218011),
      backgroundDefault: const Color(0xffFBFBFB),
      backgroundSubtle: const Color(0xffF4F4F4),
      backgroundHovered: const Color(0xffF4F4F4),
      backgroundDisabled: const Color(0xffE0E0E0),
      backgroundSelected: const Color(0xffF6EDFF),
      backgroundChecked: const Color(0xffC2C2C2),
      borderDefault: const Color(0xffE0E0E0),
      borderSubtle: const Color(0xffF4F4F4),
      borderStrong: const Color(0xffC2C2C2),
      iconDefault: const Color(0xff757575),
      iconHovered: const Color(0xff5C5C5C),
    );
  }();

  static final light = () {
    final defaultTheme = ThemeData.light();

    final colorExt = color;

    return defaultTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.seed,
        outline: AppColor.outline,
        outlineVariant: AppColor.outlineVariant,
        shadow: AppColor.shadow,
      ),
      extensions: [
        colorExt,
        spacing,
        AppTextThemeExtension(
          displayLarge: TextStyle(fontSize: 57, color: colorExt.textDefault),
          displayMedium: TextStyle(fontSize: 45, color: colorExt.textDefault),
          displaySmall: TextStyle(fontSize: 36, color: colorExt.textDefault),
          headlineLarge: TextStyle(fontSize: 32, color: colorExt.textDefault),
          headlineMedium: TextStyle(fontSize: 28, color: colorExt.textDefault),
          headlineSmall: TextStyle(fontSize: 24, color: colorExt.textDefault),
          titleLarge: TextStyle(
            fontSize: 22,
            color: colorExt.textDefault,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: colorExt.textDefault,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            color: colorExt.textDefault,
            fontWeight: FontWeight.w600,
          ),
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

    final colorExt = color;

    return defaultTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.seed,
        outline: AppColor.outline,
        outlineVariant: AppColor.outlineVariant,
        shadow: AppColor.shadow,
      ),
      extensions: [
        colorExt,
        spacing,
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

  AppSpacingExtension get appSpacing {
    return Theme.of(this).extension<AppSpacingExtension>()!;
  }
}
