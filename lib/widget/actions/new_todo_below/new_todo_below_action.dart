import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_todo_below_action.g.dart';

/// 新規[Todo]を現在のフォーカスの1つ下に作成する[Intent]
class NewTodoBelowIntent extends Intent {
  const NewTodoBelowIntent();
}

@riverpod
NewTodoBelowAction newTodoBelowAction(NewTodoBelowActionRef ref) =>
    NewTodoBelowAction(ref);

/// 新規Todoをリストの一番上に作成する[Action]
class NewTodoBelowAction extends Action<NewTodoBelowIntent> {
  NewTodoBelowAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant NewTodoBelowIntent intent) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final index =
        ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
    await ref.read(todoControllerProvider.notifier).add(index + 1);
    await ref.read(todoControllerProvider.notifier).updateCurrentOrder();
    ref.read(todoFocusControllerProvider)[index + 1].requestFocus();
    return null;
  }
}
