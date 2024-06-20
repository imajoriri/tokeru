import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/url/url_controller.dart';
import 'package:quick_flutter/screen/main/chat/chat_view.dart';
import 'package:quick_flutter/screen/main/todo/todo_view.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.appColors.backgroundDefault,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await UrlController.featureRequest.launch();
        },
        // 丸にする
        shape: CircleBorder(
          side: BorderSide(
            color: context.appColors.borderDefault,
          ),
        ),
        elevation: 1,
        focusElevation: 1,
        highlightElevation: 1,
        hoverElevation: 1,
        // ripple effectをなくす
        splashColor: Colors.transparent,
        backgroundColor: context.appColors.backgroundDefault,
        child: Icon(
          Icons.feedback_outlined,
          color: context.appColors.textSubtle,
        ),
      ),
      body: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          Expanded(child: ChatView()),

          VerticalDivider(
            width: 1,
          ),

          // Todoリスト
          Expanded(child: TodoView()),
        ],
      ),
    );
  }
}
