import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_up_action.g.dart';

/// フォーカスを上に移動する[Intent]
class FocusUpIntent extends Intent {
  const FocusUpIntent();
}

@riverpod
TodoFocusUpAction todoFocusUpAction(TodoFocusUpActionRef ref) =>
    TodoFocusUpAction(ref);

/// Todoのフォーカスを上に移動する[Action]
class TodoFocusUpAction extends CustomAction<FocusUpIntent> {
  TodoFocusUpAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusUpIntent intent) {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    final currentIndex = focusController.getFocusIndex();

    // 先頭のTodoにフォーカスがある場合は、フォーカスを移動しない
    if (currentIndex == 0) {
      return KeyEventResult.ignored;
    }

    final currentTodo =
        ref.read(todoControllerProvider).valueOrNull![currentIndex];
    final textEditingController =
        ref.read(todoTextEditingControllerProvider(currentTodo.id));

    // 日本語入力などでの変換中は無視する
    if (textEditingController.value.composing.isValid) {
      return KeyEventResult.ignored;
    }

    final isFirstLine = !textEditingController.text
        .substring(0, textEditingController.selection.baseOffset)
        .contains('\n');
    // TextEditingContollerのカーソルが一番上の行にいない場合は、フォーカスを移動しない
    if (!isFirstLine) {
      return KeyEventResult.ignored;
    }

    focusController.fucusPrevious();
    moveCursorToLastLine(
      textEditingController,
      ref.read(
        todoTextEditingControllerProvider(
          ref.read(todoControllerProvider).valueOrNull![currentIndex - 1].id,
        ),
      ),
    );
    return null;
  }

  /// [nextController]のカーソルを一番下の行に設定する。
  void moveCursorToLastLine(
    TextEditingController previousController,
    TextEditingController nextController,
  ) {
    final previousBaseOffset = previousController.selection.baseOffset;
    final nextLastLineIndex = nextController.text.lastIndexOf('\n');
    final nextTextLength = nextController.text.length;

    // 移動前のカーソルの先頭からの位置と、移動後のカーソルの最後の行の先頭からの位置を合わせる
    final lastLineOffset = nextLastLineIndex + 1 + previousBaseOffset;

    nextController.selection = TextSelection(
      baseOffset:
          lastLineOffset <= nextTextLength ? lastLineOffset : nextTextLength,
      extentOffset:
          lastLineOffset <= nextTextLength ? lastLineOffset : nextTextLength,
    );
  }
}
