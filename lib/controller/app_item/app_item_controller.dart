// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'app_item_controller.g.dart';
part 'app_item_controller.freezed.dart';

@freezed
class AppItemControllerState with _$AppItemControllerState {
  const factory AppItemControllerState({
    /// チャットUIに表示する[AppItem]。
    required List<AppItem> chatItems,

    /// 未完了の[AppTodoItem]。
    required List<AppTodoItem> todos,
  }) = _AppItemControllerState;
}

@riverpod
class AppItemController extends _$AppItemController {
  /// 1ページあたりの取得数。
  final initialPerPage = 50;

  /// 次の[AppItem]があるかどうか。
  bool hasNext = true;

  @override
  FutureOr<AppItemControllerState> build() async {
    ref.watch(refreshControllerProvider);

    // ユーザーがログインしていない場合は空を返す。
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const AppItemControllerState(
        chatItems: [],
        todos: [],
      );
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final todoResponse = await repository.fetch(
      type: 'todo',
      isDone: false,
    );
    final todos = todoResponse.whereType<AppTodoItem>().toList();
    todos.sort((a, b) => a.index.compareTo(b.index));

    final items = await repository.fetch(
      limit: initialPerPage,
    );
    return AppItemControllerState(
      chatItems: items,
      todos: todos,
    );
  }
}

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
}
