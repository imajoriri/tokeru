import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'move_down_todo_action.g.dart';

/// [Todo]を1つ上に移動させる[Intent]
class MoveDownTodoIntent extends Intent {
  const MoveDownTodoIntent();
}

@riverpod
MoveDownTodoAction moveDownTodoAction(MoveDownTodoActionRef ref) =>
    MoveDownTodoAction(ref);

/// [Todo]を1つ上に移動させる[Action]
class MoveDownTodoAction extends Action<MoveDownTodoIntent> {
  MoveDownTodoAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant MoveDownTodoIntent intent) async {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    final index = focusController.getFocusIndex();
    if (index != -1 &&
        index != ref.read(todoControllerProvider).valueOrNull!.length - 1) {
      focusController.removeFocus();
      ref.read(todoControllerProvider.notifier).reorder(index, index + 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusController.requestFocus(index + 1);
      });
    }
    return null;
  }
}
