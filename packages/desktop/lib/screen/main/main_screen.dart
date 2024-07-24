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
      backgroundColor: context.appColors.surface,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await UrlController.featureRequest.launch();
        },
        // 丸にする
        shape: CircleBorder(
          side: BorderSide(
            color: context.appColors.outline,
          ),
        ),
        elevation: 1,
        focusElevation: 1,
        highlightElevation: 1,
        hoverElevation: 1,
        // ripple effectをなくす
        splashColor: Colors.transparent,
        backgroundColor: context.appColors.surface,
        child: Icon(
          Icons.feedback_outlined,
          color: context.appColors.onSurfaceSubtle,
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          const Expanded(child: ChatView()),

          Container(
            width: 3,
            height: double.infinity,
            margin: EdgeInsets.symmetric(vertical: context.appSpacing.small),
            decoration: BoxDecoration(
              color: context.appColors.outline,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Todoリスト
          const Expanded(child: TodoView()),
        ],
      ),
    );
  }
}