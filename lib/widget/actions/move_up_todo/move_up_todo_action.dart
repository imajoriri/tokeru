import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'move_up_todo_action.g.dart';

/// [Todo]を1つ上に移動させる[Intent]
class MoveUpTodoIntent extends Intent {
  const MoveUpTodoIntent();
}

@riverpod
MoveUpTodoAction moveUpTodoAction(MoveUpTodoActionRef ref) =>
    MoveUpTodoAction(ref);

/// [Todo]を1つ上に移動させる[Action]
class MoveUpTodoAction extends Action<MoveUpTodoIntent> {
  MoveUpTodoAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant MoveUpTodoIntent intent) async {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    final index = focusController.getFocusIndex();
    if (index != -1 && index != 0) {
      focusController.removeFocus();
      ref.read(todoControllerProvider.notifier).reorder(index, index - 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusController.requestFocus(index - 1);
      });
    }
    return null;
  }
}
