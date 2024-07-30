import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Corner smoothing border
class AppSmoothRectangleBorder extends SmoothRectangleBorder {
  AppSmoothRectangleBorder({
    super.borderRadius = const BorderRadius.all(Radius.circular(8)),
    super.side,
  }) : super(smoothness: 0.6);
}
