import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';

part 'thread.g.dart';

@riverpod
class SelectedThread extends _$SelectedThread {
  StreamSubscription? _streamSub;

  @override
  AppItem? build() {
    ref.onDispose(() {
      _streamSub?.cancel();
    });
    return null;
  }

  void close() {
    state = null;
    _streamSub?.cancel();
  }

  void open(String appItemId) async {
    _streamSub?.cancel();

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.watch(appItemRepositoryProvider(user.id));
    final stream = repository.streamById(userId: user.id, id: appItemId);
    _streamSub = stream.listen((event) {
      state = event;
    });
  }

  /// [AppTodoItem]のメモを更新する。
  Future<void> updateMemo(String content) async {
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.watch(appItemRepositoryProvider(user.id));
    if (state == null || state is! AppTodoItem) {
      return;
    }
    final item = (state as AppTodoItem).copyWith(content: content);
    await repository.update(item: item);
  }
}
