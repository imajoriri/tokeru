import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/ogp_controller/ogp_controller.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/card/url_preview_card.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

part 'chat_list.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todayAppItemControllerProvider;
    final appItems = ref.watch(provider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ChatList(appItems: appItems),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          // child: _ChatTextField(),
        ),
      ],
    );
  }
}
