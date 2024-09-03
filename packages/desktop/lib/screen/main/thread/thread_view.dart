import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/generative_ai/generative_sub_todo.dart';
import 'package:tokeru_model/controller/sub_todos/sub_todos.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/thread/thread_chats.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'sub_todo.dart';
part 'header.dart';
part 'empty_state.dart';
part 'chat_text_field.dart';
part 'chat_list_item.dart';
part 'add_sub_todo_button.dart';
part 'generated_sub_todo.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (item == null) {
      return const _EmptyState();
    }

    // Todoを一番下や、Enterで1つ下に追加した時にフォーカスを当てるために使用する。
    // フォーカス後、リビルドごとにフォーカスが当たらないようにするために、nullにする。
    final currentFocusIndex = useState<int?>(null);

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
            ),
            color: context.appColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              // サブタスクのリスト
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const _ThreadHeader(),
                    const SizedBox(height: 8),
                    _SubTodoList(
                      currentFocusIndex: currentFocusIndex,
                    ),
                  ],
                ),
              ),

              // 生成されたサブタスクのリスト
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const _GeneratedSubTodo(),
                    SizedBox(height: context.appSpacing.smallX),
                    _AddSubTodoButton(currentFocusIndex: currentFocusIndex),
                    SizedBox(height: context.appSpacing.smallX),
                  ],
                ),
              ),
            ],
          ),
        ),
        const _ChatListItems(),
        const _ChatTextField(),
      ],
    );
  }
}
