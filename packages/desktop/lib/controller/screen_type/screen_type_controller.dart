import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_type_controller.g.dart';

enum ScreenType {
  todo,
  settings,
}

@riverpod
class ScreenTypeController extends _$ScreenTypeController {
  @override
  ScreenType build() {
    return ScreenType.todo;
  }

  set screenType(ScreenType value) {
    super.state = value;
  }
}
