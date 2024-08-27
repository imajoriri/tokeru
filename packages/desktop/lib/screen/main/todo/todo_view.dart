import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/todos/todos.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_desktop/widget/shortcutkey.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'today_todo_list.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: todoViewFocusNode,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([const TodayTodoList()]),
          ),
        ],
      ),
    );
  }
}
