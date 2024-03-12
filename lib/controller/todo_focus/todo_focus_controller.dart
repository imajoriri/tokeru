import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_focus_controller.g.dart';

/// Todoリストの[FocusNode]を管理するProvider
@riverpod
class TodoFocusController extends _$TodoFocusController {
  @override
  List<FocusNode> build() {
    // watchを使うと、Todoのtitleが変わった時にも発火してしまい
    // focusが外れてしまうため、todo一覧取得にはreadを使い、数の差分があった時のみinvalidateする。
    ref.listen(todoControllerProvider, (previous, next) {
      if (previous?.value?.length != next.value?.length) {
        ref.invalidateSelf();
      }
    });
    final todo = ref.read(todoControllerProvider);
    final nodes =
        List.generate(todo.valueOrNull?.length ?? 0, (index) => FocusNode());
    ref.onDispose(() {
      for (var node in nodes) {
        node.dispose();
      }
    });
    return nodes;
  }

  /// 現在のフォーカスの次にフォーカスを移動する
  ///
  /// フォーカスがない場合は何もしない。
  /// フォーカスが最後の要素にある場合は、最初の要素にフォーカスを移動する。
  void focusNext() {
    final currentFocusIndex = state.indexWhere((element) => element.hasFocus);
    if (currentFocusIndex == -1) {
      return;
    }
    final nextFocusIndex = (currentFocusIndex + 1) % state.length;
    if (state[nextFocusIndex].canRequestFocus) {
      state[nextFocusIndex].requestFocus();
    }
  }

  /// 現在のフォーカスの前にフォーカスを移動する
  ///
  /// フォーカスがない場合は何もしない。
  /// フォーカスが最初の要素にある場合は、最後の要素にフォーカスを移動する。
  void fucusPrevious() {
    final currentFocusIndex = state.indexWhere((element) => element.hasFocus);
    if (currentFocusIndex == -1) {
      return;
    }
    final previousFocusIndex = (currentFocusIndex - 1) % state.length;
    if (state[previousFocusIndex].canRequestFocus) {
      state[previousFocusIndex].requestFocus();
    }
  }

  /// 指定したindexのフォーカスを要求する
  void requestFocus(int index) {
    if (state[index].canRequestFocus) {
      state[index].requestFocus();
    }
  }
}
