import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.textDefault,
    required this.textSubtle,
    required this.textDisabled,
    required this.textDanger,
    required this.textSuccess,
    required this.backgroundDefault,
    required this.backgroundSubtle,
    required this.backgroundPrimaryContainer,
    required this.backgroundPrimaryActionEnabled,
    required this.backgroundPrimaryActionDisabled,
    required this.backgroundPrimaryActionHovered,
  });

  // Text
  final Color textDefault;
  final Color textSubtle;
  final Color textDisabled;
  final Color textDanger;
  final Color textSuccess;

  // background
  final Color backgroundDefault;
  final Color backgroundSubtle;
  final Color backgroundPrimaryContainer;

  // background/primary-action
  final Color backgroundPrimaryActionEnabled;
  final Color backgroundPrimaryActionDisabled;
  final Color backgroundPrimaryActionHovered;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? textDefault,
    Color? textSubtle,
    Color? textDisabled,
    Color? textDanger,
    Color? textSuccess,
    Color? backgroundDefault,
    Color? backgroundSubtle,
    Color? backgroundPrimaryContainer,
    Color? backgroundPrimaryActionEnabled,
    Color? backgroundPrimaryActionDisabled,
    Color? backgroundPrimaryActionHovered,
  }) {
    return AppColorsExtension(
      textDefault: textDefault ?? this.textDefault,
      textSubtle: textSubtle ?? this.textSubtle,
      textDisabled: textDisabled ?? this.textDisabled,
      textDanger: textDanger ?? this.textDanger,
      textSuccess: textSuccess ?? this.textSuccess,
      backgroundDefault: backgroundDefault ?? this.backgroundDefault,
      backgroundSubtle: backgroundSubtle ?? this.backgroundSubtle,
      backgroundPrimaryContainer:
          backgroundPrimaryContainer ?? this.backgroundPrimaryContainer,
      backgroundPrimaryActionEnabled:
          backgroundPrimaryActionEnabled ?? this.backgroundPrimaryActionEnabled,
      backgroundPrimaryActionDisabled: backgroundPrimaryActionDisabled ??
          this.backgroundPrimaryActionDisabled,
      backgroundPrimaryActionHovered:
          backgroundPrimaryActionHovered ?? this.backgroundPrimaryActionHovered,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      textDefault: Color.lerp(textDefault, other.textDefault, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textDanger: Color.lerp(textDanger, other.textDanger, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      backgroundDefault:
          Color.lerp(backgroundDefault, other.backgroundDefault, t)!,
      backgroundSubtle:
          Color.lerp(backgroundSubtle, other.backgroundSubtle, t)!,
      backgroundPrimaryContainer: Color.lerp(
        backgroundPrimaryContainer,
        other.backgroundPrimaryContainer,
        t,
      )!,
      backgroundPrimaryActionEnabled: Color.lerp(
        backgroundPrimaryActionEnabled,
        other.backgroundPrimaryActionEnabled,
        t,
      )!,
      backgroundPrimaryActionDisabled: Color.lerp(
        backgroundPrimaryActionDisabled,
        other.backgroundPrimaryActionDisabled,
        t,
      )!,
      backgroundPrimaryActionHovered: Color.lerp(
        backgroundPrimaryActionHovered,
        other.backgroundPrimaryActionHovered,
        t,
      )!,
    );
  }
}
