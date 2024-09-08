import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/todos/todos.dart';
import 'package:tokeru_model/controller/list_mode/list_mode.dart';
import 'package:tokeru_model/controller/todos/completed_todos.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'todo_list.dart';
part 'list_mode_buttons.dart';
part 'completed_todo_list.dart';

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listMode = ref.watch(listModeProvider);
    return Column(
      children: [
        const _ListModeButtons(),
        Expanded(
          child: switch (listMode) {
            ListModeType.todo => const TodoList(),
            ListModeType.done => const CompletedTodoList(),
          },
        ),
      ],
    );
  }
}
