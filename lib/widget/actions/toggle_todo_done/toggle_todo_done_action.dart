import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
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
    if (index != -1) {
      final todo = ref.read(todoControllerProvider).valueOrNull?[index];
      await ref
          .read(todoControllerProvider.notifier)
          .updateIsDone(todoId: todo!.id, isDone: !todo.isDone);

      // 削除した後に元いた場所にフォーカスを戻す
      ref.read(todoControllerProvider.notifier).deleteDoneWithDebounce(
            // ユーザーのタッチ操作ではないので、長く待つ必要もないので300ms
            milliseconds: 300,
            onDeleted: () {
              ref
                  .read(todoFocusControllerProvider.notifier)
                  .requestFocus(index);
            },
          );
    }
    return null;
  }
}
