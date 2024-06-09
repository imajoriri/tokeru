import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/main/chat/chat_view.dart';
import 'package:quick_flutter/screen/main/todo/todo_view.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Todoリスト
        Expanded(child: TodoView()),
        VerticalDivider(),

        // Chat
        Expanded(child: ChatView()),
      ],
    );
  }
}
