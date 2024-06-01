import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_flutter/controller/free_calendar_event/free_calendar_event_controller.dart';
import 'package:quick_flutter/controller/google_sign_in/google_sign_in_controller.dart';
import 'package:quick_flutter/controller/just_now_event/just_now_event_controller.dart';
import 'package:quick_flutter/controller/memo/memo_controller.dart';
import 'package:quick_flutter/controller/next_event/next_event_controller.dart';
import 'package:quick_flutter/controller/past_todo/past_todo_controller.dart';
import 'package:quick_flutter/controller/selected_todo_item/selected_todo_item_controller.dart';
import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/controller/todo_text_field_focus/todo_text_field_focus_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/widget/actions/delete_todo/delete_todo_action.dart';
import 'package:quick_flutter/widget/actions/focus_down/focus_down_action.dart';
import 'package:quick_flutter/widget/actions/focus_up/focus_up_action.dart';
import 'package:quick_flutter/widget/actions/move_down_todo/move_down_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_up_todo/move_up_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo_below/new_todo_below_action.dart';
import 'package:quick_flutter/widget/actions/toggle_todo_done/toggle_todo_done_action.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:quick_flutter/widget/todo_list_item.dart';

part 'todo_list.dart';
part 'memo.dart';
part 'todo_text_field.dart';
part 'today_section.dart';
part 'past_todo_list.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _TodaySection(),
            // Divider(),
            TodoList(),
            SizedBox(height: 28),
            PastTodoList(),
            // _TodoTextField(),
          ],
        ),
      ),
    );
  }
}
