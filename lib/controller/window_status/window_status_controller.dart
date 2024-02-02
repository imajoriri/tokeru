import 'package:quick_flutter/model/window_status/window_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_status_controller.g.dart';

@riverpod
class WindowStatusController extends _$WindowStatusController {
  @override
  WindowStatus build() {
    return WindowStatus.active;
  }

  void setActive() {
    state = WindowStatus.active;
  }

  void setInactive() {
    state = WindowStatus.inactive;
  }
}
