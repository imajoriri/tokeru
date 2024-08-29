import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/sub_todos/sub_todos.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/threads/threads.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'sub_todo.dart';
part 'header.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (item == null) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'No todo selected',
          ),
        ),
      );
    }

    final provider = threadsProvider(item.id);
    final appItems = ref.watch(provider);

    return Column(
      children: [
        const _ThreadHeader(),
        const SizedBox(height: 8),
        const _SubTodoView(),
        const SizedBox(height: 8),
        const _HeaderDivider(),
        const SizedBox(height: 8),
        Flexible(
          child: appItems.when(
            skipLoadingOnReload: true,
            data: (appItems) {
              return ChatListItems.thread(
                threads: appItems,
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, _) {
              return Center(
                child: Text('Error: $error'),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ChatTextField(
            focusNode: threadViewFocusNode,
            onSubmit: (message) async {
              ref.read(provider.notifier).add(message: message);
            },
          ),
        ),
      ],
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  const _HeaderDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            height: 1,
          ),
        ),
      ],
    );
  }
}
