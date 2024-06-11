import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_span_controller.g.dart';

@Riverpod(keepAlive: true)
class TodoSpanController extends _$TodoSpanController {
  @override
  int build() {
    return 3;
  }
}
