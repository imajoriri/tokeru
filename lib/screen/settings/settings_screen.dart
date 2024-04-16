import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFocus = useState(false);
    final focusNode = useFocusNode();
    final pressedKey = useState<List<LogicalKeyboardKey>>([]);

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          focusNode.requestFocus();
        },
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: hasFocus.value ? Colors.red : Colors.blue,
            ),
          ),
          child: Focus(
            skipTraversal: true,
            focusNode: focusNode,
            onFocusChange: (value) {
              hasFocus.value = value;
            },
            onKey: (node, event) {
              if (event is RawKeyDownEvent) {
                // pressedKeyに追加
                final tmp = [...pressedKey.value, event.logicalKey];
                pressedKey.value = tmp;
              } else if (event is RawKeyUpEvent) {
                // pressedKeyから削除
                final tmp = [...pressedKey.value];
                tmp.remove(event.logicalKey);
                pressedKey.value = tmp;
              }
              return KeyEventResult.ignored;
            },
            child: Text(pressedKey.value.toString()),
          ),
        ),
      ),
    );
  }
}
