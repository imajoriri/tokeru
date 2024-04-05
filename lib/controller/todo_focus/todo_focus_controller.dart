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
  void focusNext() {
    final currentFocusIndex = state.indexWhere((element) => element.hasFocus);
    if (currentFocusIndex == -1 || currentFocusIndex == state.length - 1) {
      return;
    }
    final nextFocusIndex = currentFocusIndex + 1;
    if (state[nextFocusIndex].canRequestFocus) {
      state[nextFocusIndex].requestFocus();
    }
  }

  /// 現在のフォーカスの前にフォーカスを移動する
  ///
  /// フォーカスがない場合は何もしない。
  void focusPrevious() {
    final currentFocusIndex = state.indexWhere((element) => element.hasFocus);
    if (currentFocusIndex == -1 || currentFocusIndex == 0) {
      return;
    }
    final previousFocusIndex = currentFocusIndex - 1;
    if (state[previousFocusIndex].canRequestFocus) {
      state[previousFocusIndex].requestFocus();
    }
  }

  /// 指定したindexのフォーカスを要求する
  void requestFocus(int index) {
    // indexが範囲外の場合は何もしない
    if (index < 0 || index >= state.length) {
      return;
    }
    if (state[index].canRequestFocus) {
      state[index].requestFocus();
    }
  }

  /// フォーカスを外す
  void removeFocus() {
    for (var node in state) {
      node.unfocus();
    }
  }

  /// フォーカスを持っている要素のindexを返す
  ///
  /// フォーカスを持っている要素がない場合は-1を返す
  int getFocusIndex() {
    return state.indexWhere((element) => element.hasFocus);
  }
}
