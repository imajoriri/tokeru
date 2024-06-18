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
    required this.backgroundHovered,
    required this.backgroundSelected,
    required this.backgroundChecked,
    required this.borderDefault,
    required this.borderSubtle,
    required this.iconDefault,
    required this.iconHovered,
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
  final Color backgroundHovered;
  final Color backgroundSelected;
  final Color backgroundChecked;

  // border
  final Color borderDefault;
  final Color borderSubtle;

  // icon
  final Color iconDefault;
  final Color iconHovered;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? textDefault,
    Color? textSubtle,
    Color? textDisabled,
    Color? textDanger,
    Color? textSuccess,
    // background
    Color? backgroundDefault,
    Color? backgroundSubtle,
    Color? backgroundHovered,
    Color? backgroundSelected,
    Color? backgroundChecked,
    // border
    Color? borderDefault,
    Color? borderSubtle,
    // icon
    Color? iconDefault,
    Color? iconHovered,
  }) {
    return AppColorsExtension(
      textDefault: textDefault ?? this.textDefault,
      textSubtle: textSubtle ?? this.textSubtle,
      textDisabled: textDisabled ?? this.textDisabled,
      textDanger: textDanger ?? this.textDanger,
      textSuccess: textSuccess ?? this.textSuccess,
      backgroundDefault: backgroundDefault ?? this.backgroundDefault,
      backgroundSubtle: backgroundSubtle ?? this.backgroundSubtle,
      backgroundHovered: backgroundHovered ?? this.backgroundHovered,
      backgroundSelected: backgroundSelected ?? this.backgroundSelected,
      backgroundChecked: backgroundChecked ?? this.backgroundChecked,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      iconDefault: iconDefault ?? this.iconDefault,
      iconHovered: iconHovered ?? this.iconHovered,
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
      backgroundHovered:
          Color.lerp(backgroundHovered, other.backgroundHovered, t)!,
      backgroundSubtle:
          Color.lerp(backgroundSubtle, other.backgroundSubtle, t)!,
      backgroundSelected:
          Color.lerp(backgroundSelected, other.backgroundSelected, t)!,
      backgroundChecked:
          Color.lerp(backgroundChecked, other.backgroundChecked, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconHovered: Color.lerp(iconHovered, other.iconHovered, t)!,
    );
  }
}
