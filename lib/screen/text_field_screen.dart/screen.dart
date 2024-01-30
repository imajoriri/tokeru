import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/provider/memo/memo_provider.dart';
import 'package:quick_flutter/provider/method_channel/method_channel_provider.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final alwaysFloating = useState(true);

    final controller = useMarkdownTextEditingController();

    ref.listen(memoProvider, (previous, next) {
      controller.text = next.valueOrNull ?? "";
    });

    return Material(
      child: Padding(
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
                    alwaysFloating.value = !alwaysFloating.value;
                    if (alwaysFloating.value) {
                      channel
                          .invokeMethod(AppMethodChannel.alwaysFloatingOn.name);
                    } else {
                      channel.invokeMethod(
                          AppMethodChannel.alwaysFloatingOff.name);
                    }
                  },
                  icon: Icon(alwaysFloating.value
                      ? Icons.bookmark
                      : Icons.bookmark_outline),
                  color: alwaysFloating.value
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
            MarkdownTextField(
              controller: controller,
              maxLines: null,
              onChanged: (value) {
                ref.read(memoProvider.notifier).updateContent(value);
              },
            ),
            const Divider(),
            Expanded(
              flex: 1,
              child: _ChatField(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatField extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textList = useState<List<String>>([]);
    final textController = useTextEditingController();

    void send() {
      textList.value = [
        textController.text,
        ...textList.value,
      ];
      textController.clear();
    }

    return CallbackShortcuts(
      bindings: {
        LogicalKeySet(LogicalKeyboardKey.enter, LogicalKeyboardKey.meta): () {
          send();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return SelectableText(textList.value[index]);
                },
                itemCount: textList.value.length,
              ),
            ),

            // textfield
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'メッセージを入力',
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    send();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
