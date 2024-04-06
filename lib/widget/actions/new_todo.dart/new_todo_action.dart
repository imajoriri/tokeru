import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_todo_action.g.dart';

/// 新規[Todo]を作成する[Intent]
class NewTodoIntent extends Intent {
  const NewTodoIntent();
}

@riverpod
NewTodoAction newTodoAction(NewTodoActionRef ref) => NewTodoAction(ref);

/// 新規Todoをリストの一番上に作成する[Action]
class NewTodoAction extends Action<NewTodoIntent> {
  NewTodoAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant NewTodoIntent intent) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await ref.read(todoControllerProvider.notifier).add(0);
    ref.read(todoFocusControllerProvider.notifier).requestFocus(0);
    return null;
  }
}
