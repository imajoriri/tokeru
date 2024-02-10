import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_size_mode_controller.g.dart';

enum WindowSizeMode { small, large }

/// [WindowSizeMode]を管理するController
@riverpod
class WindowSizeModeController extends _$WindowSizeModeController {
  @override
  WindowSizeMode build() {
    return WindowSizeMode.large;
  }

  void toLarge() {
    state = WindowSizeMode.large;
  }

  void toSmall() {
    state = WindowSizeMode.small;
  }
}
