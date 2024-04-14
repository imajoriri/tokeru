import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_todo_action.g.dart';

/// [Todo]を1つ上に移動させる[Intent]
class DeleteTodoIntent extends Intent {
  const DeleteTodoIntent();
}

@riverpod
DeleteTodoAction deleteTodoAction(DeleteTodoActionRef ref) =>
    DeleteTodoAction(ref);

/// [Todo]を1つ上に移動させる[Action]
class DeleteTodoAction extends Action<DeleteTodoIntent> {
  DeleteTodoAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant DeleteTodoIntent intent) async {
    final index =
        ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
    if (index == -1) return null;

    final todoLength = ref.read(todoControllerProvider).valueOrNull!.length;
    // 最後の１つの場合、previousFoucsすると他のFocusに移動しちゃうため何もしない
    if (todoLength == 1) return null;

    final todo = ref.read(todoControllerProvider).valueOrNull![index];
    await ref.read(todoControllerProvider.notifier).delete(todo);
    ref.read(todoFocusControllerProvider.notifier).requestFocus(index);
    return null;
  }
}
