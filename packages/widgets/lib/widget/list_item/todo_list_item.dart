import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widgets.dart';

class TodoListItem extends HookWidget {
  const TodoListItem({
    super.key,
    required this.isDone,
    this.title,
    this.index,
    this.threadCount = 0,
    this.subTodoCount = 0,
    this.onOpenThread,
    this.focusNode,
    this.autofocus = false,
    this.isSelected = false,
    this.onDeleted,
    this.onUpdatedTitle,
    this.onToggleDone,
    this.focusDown,
    this.focusUp,
    this.onNewTodoBelow,
    this.onSortUp,
    this.onSortDown,
  });

  final bool isDone;

  /// Todoのタイトル。nullの場合は空文字が表示される。
  final String? title;

  /// [AppTodoItem]のリストのIndex。
  ///
  /// nullの場合、ドラッグアンドドロップのアイコンが表示されない。
  final int? index;

  /// スレッド数。
  final int threadCount;

  /// サブTodoの件数。
  final int subTodoCount;

  /// スレッドを開くボタンを押した時のコールバック。
  final void Function()? onOpenThread;

  final bool isSelected;

  final FocusNode? focusNode;

  final bool autofocus;

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
  Widget build(BuildContext context) {
    final readOnly = onUpdatedTitle == null;
    final effectiveController = useTextEditingController(text: title);
    final effectiveFocusNode = focusNode ?? useFocusNode();
    effectiveFocusNode.skipTraversal = readOnly;
    var text = title ?? '';
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
      [effectiveController],
    );

    final backgroundColor = isSelected
        ? context.appColors.primary.withOpacity(0.08)
        : onHover.value
            ? context.appColors.onSurface.hovered
            : Colors.transparent;

    late final Color textFieldColor;
    if (isDone) {
      textFieldColor = context.appColors.onSurfaceSubtle;
    } else if (readOnly) {
      textFieldColor = context.appColors.onSurface;
    } else {
      textFieldColor = context.appColors.onSurface;
    }

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        if (onToggleDone != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.keyK): () {
            onToggleDone!(!isDone);
          },
        if (onDeleted != null)
          const SingleActivator(meta: true, LogicalKeyboardKey.keyD):
              onDeleted!,
        if (focusUp != null && !isValid.value)
          const SingleActivator(LogicalKeyboardKey.arrowUp): focusUp!,
        if (focusDown != null && !isValid.value)
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
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            // TextFieldを囲っているContainerに色を付けると
            // リビルド時にfocusが外れてしまうため、stackでContainerを分けている
            _Background(backgroundColor: backgroundColor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
                  child: CheckButton(
                    onPressed: onToggleDone,
                    checked: isDone,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      effectiveFocusNode.requestFocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
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
                        child: TextField(
                          controller: effectiveController,
                          focusNode: effectiveFocusNode,
                          style: context.appTextTheme.bodyMedium.copyWith(
                            color: textFieldColor,
                          ),
                          autofocus: autofocus,
                          cursorHeight: 16,
                          readOnly: readOnly,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'New Todo',
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // スレッド数。
                _Count(
                  onHover: onHover.value,
                  threadCount: threadCount,
                  subTodoCount: subTodoCount,
                ),
              ],
            ),
            if (onHover.value)
              _HoveredWidget(
                index: index,
                onOpenThread: onOpenThread,
              ),
          ],
        ),
      ),
    );
  }
}

/// スレッド数とサブTodoの件数を表示するWidget
class _Count extends StatelessWidget {
  const _Count({
    required this.onHover,
    required this.threadCount,
    required this.subTodoCount,
  });

  final bool onHover;
  final int threadCount;
  final int subTodoCount;

  @override
  Widget build(BuildContext context) {
    if (onHover) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (threadCount > 0)
          Padding(
            padding: EdgeInsets.only(
              right: context.appSpacing.medium,
              top: context.appSpacing.small,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.thread,
                  size: 12,
                  color: context.appColors.onSurfaceSubtle,
                ),
                const SizedBox(width: 4),
                Text(
                  '$threadCount',
                  style: context.appTextTheme.bodyMedium.copyWith(
                    color: context.appColors.onSurfaceSubtle,
                  ),
                ),
              ],
            ),
          ),
        if (subTodoCount > 0)
          Padding(
            padding: EdgeInsets.only(
              right: context.appSpacing.medium,
              top: context.appSpacing.small,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.check,
                  size: 12,
                  color: context.appColors.onSurfaceSubtle,
                ),
                const SizedBox(width: 4),
                Text(
                  '$subTodoCount',
                  style: context.appTextTheme.bodyMedium.copyWith(
                    color: context.appColors.onSurfaceSubtle,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    required this.backgroundColor,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

class _HoveredWidget extends StatelessWidget {
  const _HoveredWidget({
    required this.index,
    this.onOpenThread,
  });

  final int? index;
  final void Function()? onOpenThread;

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: Directionality.of(context),
      top: 0,
      bottom: 0,
      end: 8,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          children: [
            // TODO: ホバー時のカラーをsurfaceのままにしたい。
            if (onOpenThread != null)
              AppTextButton.small(
                onPressed: onOpenThread,
                text: const Text('Open thread'),
                skipTraversal: true,
              ),
            SizedBox(width: context.appSpacing.small),
            if (index != null)
              ReorderableDragStartListener(
                index: index!,
                child: const MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: Icon(
                    Icons.drag_indicator_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
