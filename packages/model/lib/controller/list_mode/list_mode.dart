import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_mode.g.dart';

enum ListModeType {
  todo,
  done,
}

@riverpod
class ListMode extends _$ListMode {
  @override
  ListModeType build() {
    return ListModeType.todo;
  }
}
