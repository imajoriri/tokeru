import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_mode.g.dart';

enum ListModeType {
  todo,
  done,
}

/// メインViewのリストに何を表示するか。
@riverpod
class ListMode extends _$ListMode {
  @override
  ListModeType build() {
    return ListModeType.todo;
  }

  void change(ListModeType type) {
    state = type;
  }
}
