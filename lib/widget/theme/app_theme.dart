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
      primary: Colors.cyan.shade500,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.grey.shade900,
      onSurfaceSubtle: Colors.grey.shade600,
      outline: Colors.grey.shade300,
      outlineSubtle: Colors.grey.shade200,
      outlineStrong: Colors.grey.shade400,
      link: Colors.blue.shade800,
      skeleton: Colors.grey.shade300,
    );
  }();

  static final light = () {
    final defaultTheme = ThemeData.light();

    final colorExt = color;

    return defaultTheme.copyWith(
      dividerColor: colorExt.outline,
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
          displayLarge: TextStyle(fontSize: 57, color: colorExt.onSurface),
          displayMedium: TextStyle(fontSize: 45, color: colorExt.onSurface),
          displaySmall: TextStyle(fontSize: 36, color: colorExt.onSurface),
          headlineLarge: TextStyle(fontSize: 32, color: colorExt.onSurface),
          headlineMedium: TextStyle(fontSize: 28, color: colorExt.onSurface),
          headlineSmall: TextStyle(fontSize: 24, color: colorExt.onSurface),
          titleLarge: TextStyle(
            fontSize: 22,
            color: colorExt.onSurface,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: colorExt.onSurface,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            color: colorExt.onSurface,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: colorExt.onSurface),
          bodyMedium: TextStyle(fontSize: 14, color: colorExt.onSurface),
          bodySmall: TextStyle(fontSize: 12, color: colorExt.onSurface),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
          ),
          labelMidium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
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
          displayLarge: TextStyle(fontSize: 57, color: colorExt.onSurface),
          displayMedium: TextStyle(fontSize: 45, color: colorExt.onSurface),
          displaySmall: TextStyle(fontSize: 36, color: colorExt.onSurface),
          headlineLarge: TextStyle(fontSize: 32, color: colorExt.onSurface),
          headlineMedium: TextStyle(fontSize: 28, color: colorExt.onSurface),
          headlineSmall: TextStyle(fontSize: 24, color: colorExt.onSurface),
          titleLarge: TextStyle(fontSize: 22, color: colorExt.onSurface),
          titleMedium: TextStyle(fontSize: 16, color: colorExt.onSurface),
          titleSmall: TextStyle(fontSize: 14, color: colorExt.onSurface),
          bodyLarge: TextStyle(fontSize: 16, color: colorExt.onSurface),
          bodyMedium: TextStyle(fontSize: 14, color: colorExt.onSurface),
          bodySmall: TextStyle(fontSize: 12, color: colorExt.onSurface),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
          ),
          labelMidium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorExt.onSurface,
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
