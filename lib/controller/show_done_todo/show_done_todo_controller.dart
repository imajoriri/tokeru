import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_done_todo_controller.g.dart';

/// Doneになった[TodoItem]を表示するかどうか
@Riverpod(keepAlive: true)
class ShowDoneTodoController extends _$ShowDoneTodoController {
  @override
  bool build() {
    return false;
  }
}
