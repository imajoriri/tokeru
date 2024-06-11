import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    this.controller,
    this.focusNode,
    this.onDeleted,
    this.onUpdatedTitle,
    this.onToggleDone,
  });

  final AppTodoItem todo;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// [AppTodoItem]の削除時に呼ばれるコールバック
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [AppTodoItem]のタイトルが空文字の時に、バックスペースキーが押された時
  final VoidCallback? onDeleted;

  /// [AppTodoItem]のタイトルを更新するコールバック。
  ///
  /// nullの場合、[TextField]はreadOnlyになる。
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [TextField]の内容が変更された時
  final void Function(String)? onUpdatedTitle;

  /// [AppTodoItem]のチェックを切り替えるコールバック。
  ///
  /// nullの場合、[Checkbox]はDisabledになる。
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [Checkbox]がタップされた時
  final void Function(bool?)? onToggleDone;

  /// debouce用のDuration
  static const debounceDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readOnly = onUpdatedTitle == null;
    final effectiveController = controller ?? useTextEditingController();
    final effectiveFocusNode = focusNode ?? useFocusNode();
    effectiveFocusNode.skipTraversal = readOnly;
    var text = controller?.text ?? '';
    final hasFocus = useState(effectiveFocusNode.hasFocus);
    final onHover = useState(false);

    // focusが変化したら、hasFocusを更新する
    useEffect(
      () {
        void listener() {
          hasFocus.value = effectiveFocusNode.hasFocus;
        }

        effectiveFocusNode.addListener(listener);
        return () {
          effectiveFocusNode.removeListener(listener);
        };
      },
      [effectiveFocusNode],
    );

    Timer? debounce;
    useEffect(
      () {
        effectiveController.addListener(() {
          if (debounce?.isActive ?? false) {
            debounce?.cancel();
          }

          debounce = Timer(debounceDuration, () {
            if (text != effectiveController.text) {
              onUpdatedTitle?.call(effectiveController.text);
            }
            text = effectiveController.text;
          });
        });

        return () {
          debounce?.cancel();
        };
      },
      [controller],
    );

    final backgroundColor = hasFocus.value && !readOnly
        ? context.appColors.backgroundPrimaryContainer
        : onHover.value
            ? Colors.grey[200]
            : Colors.transparent;

    return MouseRegion(
      onHover: (event) {
        onHover.value = true;
      },
      onExit: (event) {
        onHover.value = false;
      },
      child: GestureDetector(
        onTap: () {
          effectiveFocusNode.requestFocus();
        },
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            // TextFieldを囲っているContainerに色を付けると
            // リビルド時にfocusが外れてしまうため、stackでContainerを分けている
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 4, left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: todo.isDone,
                    onChanged: onToggleDone,
                    focusNode: useFocusNode(
                      skipTraversal: true,
                    ),
                  ),
                  Expanded(
                    child: Focus(
                      skipTraversal: true,
                      onKey: (node, event) {
                        if (event is RawKeyDownEvent) {
                          // バックスペースキー & カーソルが先頭の場合
                          if (event.logicalKey ==
                                  LogicalKeyboardKey.backspace &&
                              effectiveController.selection.baseOffset == 0 &&
                              effectiveController.selection.extentOffset == 0) {
                            // 空文字の場合は削除
                            if (effectiveController.text.isEmpty) {
                              onDeleted?.call();
                              return KeyEventResult.handled;
                            }
                          }
                        }
                        return KeyEventResult.ignored;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4,
                          // チェックボックスとの高さを調整するためのpadding
                          top: 6,
                        ),
                        child: TextField(
                          controller: effectiveController,
                          focusNode: effectiveFocusNode,
                          style: context.appTextTheme.bodyLarge.copyWith(
                            color: todo.isDone || readOnly
                                ? context.appColors.textSubtle
                                : context.appColors.textDefault,
                          ),
                          readOnly: readOnly,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a Todo or Memo(Shift + Enter)...',
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
