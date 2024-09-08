import 'dart:async';

import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';

part 'completed_todos.g.dart';

/// 未完了の[AppTodoItem]を返すController。
///
/// ユーザーがログインしていない場合は空を返す。
@riverpod
class CompletedTodos extends _$CompletedTodos {
  StreamSubscription? _streamSub;

  @override
  Stream<List<AppTodoItem>> build() {
    ref.watch(refreshControllerProvider);

    _listen();

    ref.onDispose(() {
      _streamSub?.cancel();
    });
    return const Stream.empty();
  }

  _listen() {
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final todoQuery = repository.query(
      userId: user.requireValue.id,
      type: const ['todo'],
      isDone: true,
      limit: 50,
    );
    _streamSub = todoQuery.snapshots().listen((event) async {
      state = AsyncData(
        event.docs
            .map((doc) => AppTodoItem.fromJson(doc.data()..['id'] = doc.id))
            .toList(),
      );
    });
  }

  void toggleTodoDone({
    required String todoId,
  }) async {
    late final AppTodoItem todo;
    state = AsyncData(
      state.valueOrNull!.map((e) {
        if (e.id == todoId) {
          todo = e.copyWith(isDone: !e.isDone);
          return todo;
        }
        return e;
      }).toList(),
    );
    final user = ref.read(userControllerProvider);
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    await repository.update(item: todo);
  }
}
