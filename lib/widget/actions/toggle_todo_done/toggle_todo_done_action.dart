import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_todo_done_action.g.dart';

/// [Todo.isDone]をチェックする[Intent]
class ToggleTodoDoneIntent extends Intent {
  const ToggleTodoDoneIntent();
}

@riverpod
ToggleTodoDoneAction toggleTodoDoneAction(ToggleTodoDoneActionRef ref) =>
    ToggleTodoDoneAction(ref);

/// [Todo.isDone]をチェックする[Action]
class ToggleTodoDoneAction extends Action<ToggleTodoDoneIntent> {
  ToggleTodoDoneAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant ToggleTodoDoneIntent intent) async {
    final index =
        ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
    final focusIsLastTodo =
        ref.read(todoFocusControllerProvider).length == index + 1;
    if (index != -1) {
      final todo =
          ref.read(todoControllerProvider).valueOrNull?[index] as Todo?;
      await ref.read(todoControllerProvider.notifier).updateIsDone(
            todoId: todo!.id,
            isDone: !todo.isDone,
            milliseconds: 300,
            onUpdated: () {
              // Todoの最後にフォーカスしていた場合は、一つ前のTodoにフォーカスを移す
              // Todo最後以外にフォーカスしていた場合は、削除したTodoの次のTodoにフォーカスを移す
              final nextIndex = focusIsLastTodo ? index - 1 : index;
              ref
                  .read(todoFocusControllerProvider.notifier)
                  .requestFocus(nextIndex);
            },
          );
    }
    return null;
  }
}
