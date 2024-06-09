import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/selected_todo_item/selected_todo_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_todo_up_action.g.dart';

/// 選択中のTodoを1つ上に移動する[Intent]
class SelectTodoUpIntent extends Intent {
  const SelectTodoUpIntent();
}

@riverpod
SelectTodoUpAction selectTodoUpAction(SelectTodoUpActionRef ref) =>
    SelectTodoUpAction(ref);

class SelectTodoUpAction extends CustomAction<SelectTodoUpIntent> {
  SelectTodoUpAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant SelectTodoUpIntent intent) {
    final todos = ref.read(todoControllerProvider).valueOrNull ?? [];
    final selectedTodoId = ref.read(selectedTodoItemIdControllerProvider);
    final index = todos.indexWhere((element) => element.id == selectedTodoId);
    if (index > 0) {
      ref
          .read(selectedTodoItemIdControllerProvider.notifier)
          .select(todos[index - 1].id);
    }
    return null;
  }
}
