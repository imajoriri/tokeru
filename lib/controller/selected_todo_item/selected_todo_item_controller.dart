import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_todo_item_controller.g.dart';

/// 選択されている[TodoItem]を管理するコントローラー。
///
/// 選択されていない場合はnullを返す。
@riverpod
class SelectedTodoItemController extends _$SelectedTodoItemController {
  @override
  int? build() {
    return null;
  }

  /// 指定した[id]に置き換える。
  void select(int id) {
    state = id;
  }
}
