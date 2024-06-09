import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/screen/main/chat/chat_view.dart';
import 'package:quick_flutter/screen/main/todo/todo_view.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          _Header(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Todoリスト
                Expanded(child: TodoView()),
                VerticalDivider(),

                // Chat
                Expanded(child: ChatView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // 右がわのアイコン
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: ShortcutActivatorType.newTodo.longLabel,
                onPressed: () async {
                  await ref.read(todoControllerProvider.notifier).add(0);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref
                        .read(todoFocusControllerProvider.notifier)
                        .requestFocus(0);
                  });

                  await FirebaseAnalytics.instance.logEvent(
                    name: AnalyticsEventName.addTodo.name,
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
