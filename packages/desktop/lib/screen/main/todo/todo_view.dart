import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/controller/todo/todo_controller.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_desktop/widget/shortcutkey.dart';
import 'package:tokeru_desktop/widget/text_editing_controller/todo_text_editing_controller.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'today_todo_list.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: todoViewFocusNode,
      child: CustomScrollView(
        semanticChildCount: 3,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([const TodayTodoList()]),
          ),
        ],
      ),
    );
  }
}
