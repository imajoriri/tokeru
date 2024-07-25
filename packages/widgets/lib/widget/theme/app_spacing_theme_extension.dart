import 'dart:ui';

import 'package:flutter/material.dart';

class AppSpacingExtension extends ThemeExtension<AppSpacingExtension> {
  AppSpacingExtension({
    required this.none,
    required this.smallX,
    required this.small,
    required this.medium,
    required this.large,
  });

  final double none;
  final double smallX;
  final double small;
  final double medium;
  final double large;

  @override
  ThemeExtension<AppSpacingExtension> copyWith({
    double? none,
    double? smallX,
    double? small,
    double? medium,
    double? large,
  }) {
    return AppSpacingExtension(
      none: none ?? this.none,
      smallX: smallX ?? this.smallX,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  @override
  ThemeExtension<AppSpacingExtension> lerp(
    covariant ThemeExtension<AppSpacingExtension>? other,
    double t,
  ) {
    if (other is! AppSpacingExtension) {
      return this;
    }

    return AppSpacingExtension(
      none: lerpDouble(none, other.none, t)!,
      smallX: lerpDouble(smallX, other.smallX, t)!,
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }
}
