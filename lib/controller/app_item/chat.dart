// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

// part of 'app_item_controller.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/app_item/app_item_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

/// チャット関連の処理をまとめた[AppItemController]の拡張。
extension AppItemControllerChat on AppItemController {
  /// 次の[AppItem]を取得する
  Future<void> fetchNextChats() async {
    // 次の[AppItem]がない場合は何もしない。
    if (!hasNext) {
      return;
    }

    if (state.isLoading || state.isRefreshing || state.hasError) {
      return;
    }
    final value = state.valueOrNull;
    if (value == null) {
      return;
    }

    state =
        const AsyncLoading<AppItemControllerState>().copyWithPrevious(state);
    try {
      final user = ref.read(userControllerProvider).requireValue;
      final repository = ref.read(appItemRepositoryProvider(user.id));
      final last = value.chatItems.last;
      final chats = await repository.fetch(
        end: last.createdAt,
        limit: initialPerPage,
      );
      if (chats.isEmpty) {
        hasNext = false;
      }
      state = AsyncData(
        AppItemControllerState(
          chatItems: [
            ...value.chatItems,
            ...chats,
          ],
          todos: value.todos,
        ),
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// [AppChatItem]を追加する
  Future<void> addChat({
    required String message,
  }) async {
    final chat = AppChatItem(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
    );
    final previouse = state.valueOrNull;
    state = AsyncValue.data(
      AppItemControllerState(
        chatItems: [chat, ...previouse!.chatItems],
        todos: previouse.todos,
      ),
    );
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(chat);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// [AppChatItem]を[AppTodoItem]に変換する
  ///
  /// Chatのmessageをtitleに変換する。
  Future<void> convertToTodo({
    required String chatId,
  }) async {
    final user = ref.read(userControllerProvider).requireValue;
    // Todoに変換するChatのIndex。
    final chatIndex =
        state.valueOrNull!.chatItems.indexWhere((e) => e.id == chatId);
    final chat = state.valueOrNull!.chatItems[chatIndex];
    if (chat is! AppChatItem) {
      assert(false, 'chat is null or not AppChatItem');
      return;
    }
    final convertedTodo = AppTodoItem(
      id: chat.id,
      title: chat.message,
      isDone: false,
      index: 0,
      createdAt: chat.createdAt,
    );
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.update(item: convertedTodo);
      final tmp = [...state.requireValue.chatItems];
      final index = tmp.indexWhere((element) => element.id == chat.id);
      if (index != -1) {
        tmp[index] = convertedTodo;
      }
      state = AsyncData(
        AppItemControllerState(
          chatItems: tmp,
          todos: state.requireValue.todos,
        ),
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
