import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_list_mode.g.dart';

/// スレッドのTodoリストの表示モード。
enum ThreadListModeType {
  /// 未完了のTodoのみ表示する。
  todo,

  /// 完了のTodoを表示する。
  done,
}

@riverpod
class ThreadListMode extends _$ThreadListMode {
  @override
  ThreadListModeType build() {
    return ThreadListModeType.todo;
  }

  /// 表示モードを切り替える。
  Future<void> toggle() async {
    state = state == ThreadListModeType.todo
        ? ThreadListModeType.done
        : ThreadListModeType.todo;
  }
}
