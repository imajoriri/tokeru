import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/memo/memo_controller.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/window_size_mode/window_size_mode_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_hot_key/super_hot_key.dart';

part 'screen.g.dart';
part 'todo_list.dart';
part 'memo.dart';

@Riverpod(keepAlive: true)
class BookmarkController extends _$BookmarkController {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

class TextFieldScreen extends HookConsumerWidget {
  const TextFieldScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final windowSizeMode = ref.watch(windowSizeModeControllerProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);

    HotKey.create(
      definition: HotKeyDefinition(
        key: PhysicalKeyboardKey.comma,
        shift: true,
        meta: true,
      ),
      onPressed: () {
        final channel = ref.read(methodChannelProvider);
        channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
      },
    );

    ref.listen(windowSizeModeControllerProvider, (previous, next) {
      final _ = switch (next) {
        WindowSizeMode.small => {
            ref.read(methodChannelProvider).invokeMethod(
                AppMethodChannel.setFrameSize.name, {"height": 50}),
          },
        WindowSizeMode.large => {
            ref.read(methodChannelProvider).invokeMethod(
                AppMethodChannel.setFrameSize.name, {"height": 700}),
          },
      };
    });

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'inactive':
          if (!bookmark) {
            ref.read(windowSizeModeControllerProvider.notifier).toSmall();
          }
          break;
      }
      return null;
    });

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            switch (windowSizeMode) {
              WindowSizeMode.small => _SmallWindow(),
              WindowSizeMode.large => _LargeWindow(),
            },
          ],
        ),
      ),
    );
  }
}

class _SmallWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(todoControllerProvider);
    const index = 0;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(windowSizeModeControllerProvider.notifier).toLarge();
      },
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: asyncValue.when(
          data: (todos) {
            if (todos.isEmpty) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(todoControllerProvider.notifier).add(0);
                },
                child: const Text("追加"),
              );
            }
            final todo = todos[index];
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Checkbox(
                    value: todo.isDone,
                    onChanged: (value) async {
                      await ref
                          .read(todoControllerProvider.notifier)
                          .updateIsDone(index);
                    },
                    focusNode: useFocusNode(
                      skipTraversal: true,
                    ),
                  ),
                  Text(todo.title),
                ],
              ),
            );
          },
          error: (e, s) => const SizedBox(),
          loading: () => const SizedBox(),
        ),
      ),
    );
  }
}

class _LargeWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 4, right: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    channel.invokeMethod(AppMethodChannel.windowToLeft.name);
                  },
                  icon: const Icon(Icons.arrow_circle_left_outlined)),
              IconButton(
                onPressed: () {
                  ref.read(bookmarkControllerProvider.notifier).toggle();
                },
                icon: Icon(bookmark ? Icons.bookmark : Icons.bookmark_outline),
                color: bookmark
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
              IconButton(
                  onPressed: () {
                    channel.invokeMethod(AppMethodChannel.windowToRight.name);
                  },
                  icon: const Icon(Icons.arrow_circle_right_outlined)),
            ],
          ),
          const TodoList(),
          _MemoScreen(),
        ],
      ),
    );
  }
}

// class _ChatField extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final textList = useState<List<String>>([]);
//     final textController = useMarkdownTextEditingController();

//     void send() {
//       textList.value = [
//         textController.text,
//         ...textList.value,
//       ];
//       textController.clear();
//     }

//     return CallbackShortcuts(
//       bindings: {
//         LogicalKeySet(LogicalKeyboardKey.enter, LogicalKeyboardKey.meta): () {
//           send();
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 reverse: true,
//                 itemBuilder: (context, index) {
//                   return _ChatTile(text: textList.value[index]);
//                 },
//                 itemCount: textList.value.length,
//               ),
//             ),
//             const SizedBox(height: 4),

//             // textfield
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: MarkdownTextField(
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.all(8),
//                       hintText: 'メッセージを入力',
//                     ),
//                     maxLines: null,
//                   ),
//                 ),
//                 const SizedBox(width: 4),
//                 IconButton(
//                   onPressed: () {
//                     send();
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ChatTile extends HookConsumerWidget {
//   const _ChatTile({
//     required this.text,
//   });
//   final String text;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final onHover = useState(false);
//     return MouseRegion(
//       onExit: (pointer) {
//         onHover.value = false;
//       },
//       onEnter: (event) {
//         onHover.value = true;
//       },
//       child: Container(
//         color: onHover.value
//             ? Theme.of(context).hoverColor
//             : Theme.of(context).colorScheme.surface,
//         padding: const EdgeInsets.only(top: 4, bottom: 4),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // グレーの丸ぽち
//             Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(
//                   color: Colors.grey,
//                   shape: BoxShape.circle,
//                 ),
//                 margin: const EdgeInsets.only(top: 10, right: 12)),
//             Expanded(
//               child: SelectableText(
//                 text,
//                 style: context.textTheme.bodyLarge,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
