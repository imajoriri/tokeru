import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.onDeleted,
    this.onUpdate,
    this.onToggleDone,
  });

  final Todo todo;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// [Todo]の編集ができるかどうか。
  final bool readOnly;

  /// [Todo]の削除時に呼ばれるコールバック
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [Todo]のタイトルが空文字の時に、バックスペースキーが押された時
  final VoidCallback? onDeleted;

  /// [Todo]のタイトルを更新するコールバック。
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [TextField]の内容が変更された時
  final void Function(String)? onUpdate;

  /// [Todo]のチェックを切り替えるコールバック。
  ///
  /// このメソッドは以下のタイミングで呼ばれる。
  /// - [Checkbox]がタップされた時
  final void Function(bool?)? onToggleDone;

  /// debouce用のDuration
  static const debounceDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final effectiveController = controller ?? useTextEditingController();
    final effectiveFocusNode = focusNode ?? useFocusNode();
    final hasFocus = useState(focusNode?.hasFocus ?? false);
    var text = controller?.text ?? '';

    useEffect(
      () {
        listener() {
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
              onUpdate?.call(effectiveController.text);
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

    return Stack(
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
              color: hasFocus.value
                  ? context.appColors.backgroundPrimaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 4,
            top: 4,
            // indexに応じて左にpaddingを追加する。
            // また、チェックボックスが微妙に左にずれるため、4px右にずらす。
            left: 20 * todo.indentLevel.toDouble() + 8,
          ),
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
                      if (event.logicalKey == LogicalKeyboardKey.backspace &&
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
    );
  }
}
