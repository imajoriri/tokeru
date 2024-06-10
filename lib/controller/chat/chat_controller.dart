import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/chat/chat.dart';
import 'package:quick_flutter/repository/chat/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

const cacheTime = Duration(hours: 5);

/// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
///
/// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<List<Chat>> build(String? todoId) async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    final link = ref.keepAlive();
    final timer = Timer(cacheTime, link.close);
    ref.onDispose(timer.cancel);

    final repository = ref.watch(chatRepositoryProvider(user.value!.id));
    if (todoId == null) {
      return repository.fetchAllChats();
    } else {
      return repository.fetchChats(todoId);
    }
  }

  /// [Chat]を追加する。
  Future<void> addChat({
    required String body,
    String? todoId,
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return;
    }
    final repository = ref.read(chatRepositoryProvider(user.value!.id));
    try {
      final chat = await repository.addChat(
        todoId: todoId,
        body: body,
        createdAt: DateTime.now(),
      );
      // stateを更新する。
      state = AsyncData([chat, ...state.requireValue]);
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
