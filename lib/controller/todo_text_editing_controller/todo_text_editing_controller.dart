import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_text_editing_controller.g.dart';

/// Todoリストの[Text]を管理するProvider
@riverpod
class TodoTextEditingController extends _$TodoTextEditingController {
  @override
  List<TextEditingController> build() {
    // watchを使うと、Todoのtitleが変わった時にも発火してしまい
    // focusが外れてしまうため、todo一覧取得にはreadを使い、数の差分があった時のみinvalidateする。
    ref.listen(todoControllerProvider, (previous, next) {
      if (previous?.value?.length != next.value?.length) {
        ref.invalidateSelf();
      }
    });
    // todoの数の変化以外で更新されたくないので、readを使う
    final todo = ref.read(todoControllerProvider);

    final textEditingControllers = List.generate(
      todo.valueOrNull?.length ?? 0,
      (index) => TextEditingController(text: todo.valueOrNull![index].title),
    );

    ref.onDispose(() {
      for (var c in textEditingControllers) {
        c.dispose();
      }
    });
    return textEditingControllers;
  }
}
