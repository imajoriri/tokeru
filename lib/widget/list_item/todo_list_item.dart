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
    this.index,
    this.controller,
    this.focusNode,
    this.onDeleted,
    this.onUpdatedTitle,
    this.onToggleDone,
    this.focusDown,
    this.focusUp,
    this.onNewTodoBelow,
    this.onSortUp,
    this.onSortDown,
  });

  final AppTodoItem todo;

  /// [AppTodoItem]のリストのIndex。
  ///
  /// nullの場合、ドラッグアンドドロップのアイコンが表示されない。
  final int? index;

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

  /// 下の[TodoListItem]にフォーカスを移動するコールバック。
  final VoidCallback? focusDown;

  /// 上の[TodoListItem]にフォーカスを移動するコールバック。
  final VoidCallback? focusUp;

  /// Enterを押した際に呼ばれるコールバック。
  ///
  /// 現在のTodoの下に新しいTodoを追加することを想定している。
  final VoidCallback? onNewTodoBelow;

  /// 現在のTodoのソートを1つ上に移動するコールバック。
  ///
  /// nullの場合、上に移動できない。
  final Function()? onSortUp;

  /// 現在のTodoのソートを1つ下に移動するコールバック。
  ///
  /// nullの場合、下に移動できない。
  final Function()? onSortDown;

  /// debouce用のDuration
  static const _debounceDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readOnly = onUpdatedTitle == null;
    final effectiveController = controller ?? useTextEditingController();
    final effectiveFocusNode = focusNode ?? useFocusNode();
    effectiveFocusNode.skipTraversal = readOnly;
    var text = controller?.text ?? '';
    final hasFocus = useState(effectiveFocusNode.hasFocus);
    final onHover = useState(false);

    // 日本語入力などでの変換中は無視するためのフラグ
    final isValid = useState(false);
    effectiveFocusNode.onKeyEvent = ((node, event) {
      isValid.value = effectiveController.value.composing.isValid;
      return KeyEventResult.ignored;
    });

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

          debounce = Timer(_debounceDuration, () {
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
        ? context.appColors.backgroundSelected
        : onHover.value
            ? context.appColors.backgroundHovered
            : Colors.transparent;

    late final Color textFieldColor;
    if (todo.isDone) {
      textFieldColor = context.appColors.textSubtle;
    } else if (readOnly) {
      textFieldColor = context.appColors.textDisabled;
    } else {
      textFieldColor = context.appColors.textDefault;
    }

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        if (onToggleDone != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.keyK): () {
            onToggleDone!(!todo.isDone);
          },
        if (onDeleted != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.keyD):
              onDeleted!,
        if (focusUp != null)
          const SingleActivator(LogicalKeyboardKey.arrowUp): focusUp!,
        if (focusDown != null)
          const SingleActivator(LogicalKeyboardKey.arrowDown): focusDown!,
        if (onNewTodoBelow != null && !isValid.value)
          const SingleActivator(LogicalKeyboardKey.enter): onNewTodoBelow!,
        if (onSortUp != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.arrowUp):
              onSortUp!,
        if (onSortDown != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.arrowDown):
              onSortDown!,
      },
      child: MouseRegion(
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
                    borderRadius: BorderRadius.circular(8),
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
                      // リップルエフェクトをなくす対応。
                      splashRadius: 0,
                      fillColor: WidgetStateProperty.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return context.appColors.backgroundChecked;
                          }
                          if (states.contains(WidgetState.disabled)) {
                            return context.appColors.backgroundChecked;
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: Focus(
                        skipTraversal: true,
                        onKeyEvent: (node, event) {
                          if (event is KeyDownEvent) {
                            // バックスペースキー & カーソルが先頭の場合
                            if (event.logicalKey ==
                                    LogicalKeyboardKey.backspace &&
                                effectiveController.selection.baseOffset == 0 &&
                                effectiveController.selection.extentOffset ==
                                    0) {
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
                            top: 8,
                          ),
                          child: TextField(
                            controller: effectiveController,
                            focusNode: effectiveFocusNode,
                            style: context.appTextTheme.bodyMedium.copyWith(
                              color: textFieldColor,
                            ),
                            readOnly: readOnly,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  'Write a Todo or Memo(Shift + Enter)...',
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (onHover.value && index != null)
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: 0,
                  bottom: 0,
                  end: 8,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ReorderableDragStartListener(
                      index: index!,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.grab,
                        child: Icon(
                          Icons.drag_indicator_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
