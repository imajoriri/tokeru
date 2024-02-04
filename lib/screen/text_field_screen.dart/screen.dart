import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/provider/memo/memo_provider.dart';
import 'package:quick_flutter/provider/method_channel/method_channel_provider.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

enum _WindowSizeMode { small, large }

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final channel = ref.watch(methodChannelProvider);
    final windowSizeMode = useState<_WindowSizeMode>(_WindowSizeMode.large);
    final bookmark = useState(true);
    final controller = useMarkdownTextEditingController();

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
      return switch (call.method) {
        'active' => {
            if (bookmark.value) ...{
              windowSizeMode.value = _WindowSizeMode.large,
            },
            // focusNode.requestFocus(),
            // ref.read(windowStatusControllerProvider.notifier).setActive(),
          },
        'inactive' => {
            if (bookmark.value) ...{
              windowSizeMode.value = _WindowSizeMode.small,
              focusNode.unfocus(),
            },
            // ref.read(windowStatusControllerProvider.notifier).setInactive(),
          },
        _ => null,
      };
    });

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
                    bookmark.value = !bookmark.value;
                  },
                  icon: Icon(
                      bookmark.value ? Icons.bookmark : Icons.bookmark_outline),
                  color: bookmark.value
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
              child: MarkdownTextField(
                controller: controller,
                focus: focusNode,
                maxLines: null,
                onChanged: (value) {
                  ref.read(memoProvider.notifier).updateContent(value);
                },
              ),
            ),
            // if (ref.watch(windowStatusControllerProvider) ==
            //     WindowStatus.active) ...[
            //   const Divider(),
            //   Expanded(
            //     flex: 1,
            //     child: _ChatField(),
            //   ),
            // ],
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
    final textController = useMarkdownTextEditingController();

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
                  return _ChatTile(text: textList.value[index]);
                },
                itemCount: textList.value.length,
              ),
            ),
            const SizedBox(height: 4),

            // textfield
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: MarkdownTextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
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

class _ChatTile extends HookConsumerWidget {
  const _ChatTile({
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);
    return MouseRegion(
      onExit: (pointer) {
        onHover.value = false;
      },
      onEnter: (event) {
        onHover.value = true;
      },
      child: Container(
        color: onHover.value
            ? Theme.of(context).hoverColor
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // グレーの丸ぽち
            Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 10, right: 12)),
            Expanded(
              child: SelectableText(
                text,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
