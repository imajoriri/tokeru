import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/todos/todos.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'today_todo_list.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
          child: Row(
            children: [
              AppTextButton.small(
                onPressed: () async {},
                text: const Text('To-Do'),
                buttonType: AppTextButtonType.textSelected,
              ),
              const SizedBox(width: 4),
              AppTextButton.small(
                onPressed: () async {},
                text: const Text('Completed'),
                buttonType: AppTextButtonType.textNotSelected,
              ),
            ],
          ),
        ),
        Expanded(
          child: FocusScope(
            node: todoViewFocusNode,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([const TodayTodoList()]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
