import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/updated_todo/updated_todo.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/button/icon_button.dart';
import 'package:quick_flutter/widget/button/text_button.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';
import 'package:quick_flutter/widget/text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:quick_flutter/widget/list_item/todo_list_item.dart';

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
