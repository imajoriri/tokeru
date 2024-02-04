import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/provider/memo/memo_provider.dart';
import 'package:quick_flutter/provider/method_channel/method_channel_provider.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quill_html_converter/quill_html_converter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_hot_key/super_hot_key.dart';

part 'screen.g.dart';

enum _WindowSizeMode { small, large }

@Riverpod(keepAlive: true)
class BookmarkController extends _$BookmarkController {
  @override
  bool build() {
    return true;
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
    final windowSizeMode = useState<_WindowSizeMode>(_WindowSizeMode.large);
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

    useEffect(() {
      final _ = switch (windowSizeMode.value) {
        _WindowSizeMode.small => {
            ref.read(methodChannelProvider).invokeMethod(
                AppMethodChannel.setFrameSize.name, {"height": 100}),
          },
        _WindowSizeMode.large => {
            ref.read(methodChannelProvider).invokeMethod(
                AppMethodChannel.setFrameSize.name, {"height": 700}),
          },
      };
      return null;
    }, [windowSizeMode.value]);

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'active':
          if (bookmark) {
            windowSizeMode.value = _WindowSizeMode.large;
          }
          break;
        case 'inactive':
          if (bookmark) {
            windowSizeMode.value = _WindowSizeMode.small;
          }
          break;
      }
      return null;
    });

    return Material(
      child: switch (windowSizeMode.value) {
        _WindowSizeMode.small => _SmallWindow(),
        _WindowSizeMode.large => _LargeWindow(),
      },
    );
  }
}

class _SmallWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ref.watch(memoProvider);
    // memoの最初の1行を取得
    final firstLine = memo.valueOrNull?.split("\n").first ?? "";
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(firstLine),
    );
  }
}

class _LargeWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final controller = QuillController.basic();
    final focusNode = useFocusNode();

    final bookmark = ref.watch(bookmarkControllerProvider);
    ref.read(memoProvider.future).then((html) {
      controller.setContents(Document.fromHtml(html));

      // この外でlistenすると、setContentsの後に変更があった場合に反応しない
      controller.document.changes.listen((data) {
        ref
            .read(memoProvider.notifier)
            .updateHTML(controller.document.toDelta().toHtml());
      });
    });

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 4, right: 4),
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
          Expanded(
            child: QuillEditor.basic(
              focusNode: focusNode,
              configurations: QuillEditorConfigurations(
                controller: controller,
                readOnly: false,
                expands: true,
              ),
            ),
          ),
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
