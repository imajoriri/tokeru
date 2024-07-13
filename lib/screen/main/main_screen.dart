import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_add/todo_add_controller.dart';
import 'package:quick_flutter/controller/todo_delete/todo_delete_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/screen/main/chat/chat_view.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';
import 'package:quick_flutter/widget/button/text_button.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/list_item/todo_list_item.dart';
import 'package:quick_flutter/widget/text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

part 'todo_section.dart';
part 'chat_text_field.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.appColors.backgroundDefault,
      // floatingActionButton: FloatingActionButton.small(
      //   onPressed: () async {
      //     await UrlController.featureRequest.launch();
      //   },
      //   // 丸にする
      //   shape: CircleBorder(
      //     side: BorderSide(
      //       color: context.appColors.borderDefault,
      //     ),
      //   ),
      //   elevation: 1,
      //   focusElevation: 1,
      //   highlightElevation: 1,
      //   hoverElevation: 1,
      //   // ripple effectをなくす
      //   splashColor: Colors.transparent,
      //   backgroundColor: context.appColors.backgroundDefault,
      //   child: Icon(
      //     Icons.feedback_outlined,
      //     color: context.appColors.textSubtle,
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          const Expanded(child: ChatView()),

          Container(
            width: double.infinity,
            height: 3,
            margin: EdgeInsets.symmetric(horizontal: context.appSpacing.small),
            decoration: BoxDecoration(
              color: context.appColors.borderDefault,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const _TodoSction(),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: _ChatTextField(),
          ),
        ],
      ),
    );
  }
}
