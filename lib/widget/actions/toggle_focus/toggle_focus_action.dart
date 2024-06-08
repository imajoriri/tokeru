import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/selected_todo_item/selected_todo_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_focus_action.g.dart';

/// TodoとChatのフォーカスを切り替える[Intent]
class ToggleFocusIntent extends Intent {
  const ToggleFocusIntent();
}

@riverpod
ToggleFocusAction toggleFocusAction(ToggleFocusActionRef ref) =>
    ToggleFocusAction(ref);

class ToggleFocusAction extends CustomAction<ToggleFocusIntent> {
  ToggleFocusAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant ToggleFocusIntent intent) async {
    // Todoにフォーカスがある場合はChatにフォーカスを移動する
    final hasFocusTodo =
        ref.read(todoFocusControllerProvider.notifier).getFocusIndex() != -1;
    if (hasFocusTodo) {
      chatFocusNode.requestFocus();
      return null;
    }

    final hasFocusChat = chatFocusNode.hasFocus;
    if (hasFocusChat) {
      final todoId = ref.read(selectedTodoItemIdControllerProvider);
      final index = ref.read(todoControllerProvider).valueOrNull?.indexWhere(
            (element) => element.id == todoId,
          );
      if (index != null) {
        ref.read(todoFocusControllerProvider.notifier).requestFocus(index);
      }
      return null;
    }

    return KeyEventResult.ignored;
  }
}
