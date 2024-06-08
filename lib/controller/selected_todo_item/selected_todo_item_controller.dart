import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_todo_item_controller.g.dart';

/// 選択されている[TodoItem]のIDを管理するコントローラー。
///
/// 選択されていない場合はnullを返す。
@riverpod
class SelectedTodoItemIdController extends _$SelectedTodoItemIdController {
  @override
  String? build() {
    return null;
  }

  /// 指定した[id]に置き換える。
  void select(String id) {
    state = id;
  }
}
