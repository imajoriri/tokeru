import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    // Primary
    required this.primary,
    required this.onPrimary,

    // surface
    required this.surface,
    required this.onSurface,
    required this.onSurfaceSubtle,

    // outline
    required this.outline,
    required this.outlineSubtle,
    required this.outlineStrong,

    // others
    required this.link,
    required this.skeleton,
  });

  // Primary
  final Color primary;
  final Color onPrimary;

  // surface
  final Color surface;
  final Color onSurface;
  final Color onSurfaceSubtle;

  // outline
  final Color outline;
  final Color outlineSubtle;
  final Color outlineStrong;

  // others
  final Color link;
  final Color skeleton;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    // Primary
    Color? primary,
    Color? onPrimary,

    // surface
    Color? surface,
    Color? onSurface,
    Color? onSurfaceSubtle,

    // outline
    Color? outline,
    Color? outlineSubtle,
    Color? outlineStrong,

    // others
    Color? link,
    Color? skeleton,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceSubtle: onSurfaceSubtle ?? this.onSurfaceSubtle,
      outline: outline ?? this.outline,
      outlineSubtle: outlineSubtle ?? this.outlineSubtle,
      outlineStrong: outlineStrong ?? this.outlineStrong,
      link: link ?? this.link,
      skeleton: skeleton ?? this.skeleton,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    return this;
  }
}
