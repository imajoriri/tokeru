import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/app_item_should_update/app_item_should_update_controller.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'today_app_item_controller.g.dart';

/// 今日作成された[AppItem]を返すController。
@Riverpod(keepAlive: true)
class TodayAppItemController extends _$TodayAppItemController {
  /// 1ページあたりの取得数。
  final initialPerPage = 50;

  /// 次の[AppItem]があるかどうか。
  bool hasNext = true;

  @override
  FutureOr<List<AppItem>> build() async {
    ref.watch(refreshControllerProvider);
    ref.watch(appItemShouldUpdateControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final todos = await repository.fetch(
      limit: initialPerPage,
    );
    return todos;
  }

  // /// 次の[AppItem]を取得する
  // Future<void> fetchNext() async {
  //   // 次の[AppItem]がない場合は何もしない。
  //   if (!hasNext) {
  //     return;
  //   }

  //   if (state.isLoading || state.isRefreshing || state.hasError) {
  //     return;
  //   }
  //   final value = state.valueOrNull;
  //   if (value == null) {
  //     return;
  //   }

  //   state = const AsyncLoading<List<AppItem>>().copyWithPrevious(state);
  //   try {
  //     final user = ref.read(userControllerProvider).requireValue;
  //     final repository = ref.read(appItemRepositoryProvider(user.id));
  //     final last = value.last;
  //     final todos = await repository.fetch(
  //       end: last.createdAt,
  //       limit: initialPerPage,
  //     );
  //     if (todos.isEmpty) {
  //       hasNext = false;
  //     }
  //     state = AsyncData([...value, ...todos]);
  //   } on Exception catch (e, s) {
  //     await FirebaseCrashlytics.instance.recordError(e, s);
  //   }
  // }

  /// [AppTodoItem]を更新する。
  ///
  /// 存在しない場合は、何もしない。
  void updateTodo({
    required AppTodoItem todo,
  }) async {
    final oldTodo = state.valueOrNull?.firstWhereOrNull((e) => e.id == todo.id);
    if (oldTodo == null) {
      return;
    }

    state = AsyncData(
      state.valueOrNull!.map((e) {
        if (e.id == todo.id) {
          return todo;
        }
        return e;
      }).toList(),
    );
  }

  /// [AppTodoItem]を削除する
  ///
  /// [AppTodoItem]が存在しない場合は何もしない。
  void deleteTodo({
    required String todoId,
  }) async {
    final oldTodo = state.valueOrNull?.firstWhereOrNull((e) => e.id == todoId);
    if (oldTodo == null) {
      return;
    }

    state = AsyncData(
      state.valueOrNull!.where((e) => e.id != todoId).toList(),
    );
  }

  /// [AppTodoItem]を先頭に追加する
  void addTodo({
    required AppTodoItem todo,
  }) {
    final tmp = [...state.valueOrNull!];
    tmp.insert(0, todo);
    state = AsyncData(tmp);
  }

  // /// [AppChatItem]を追加する
  // Future<void> addChat({
  //   required String message,
  // }) async {
  //   final chat = AppChatItem(
  //     id: const Uuid().v4(),
  //     message: message,
  //     createdAt: DateTime.now(),
  //   );
  //   state = AsyncData([chat, ...state.value!]);
  //   final user = ref.read(userControllerProvider).requireValue;
  //   final repository = ref.read(appItemRepositoryProvider(user.id));
  //   try {
  //     await repository.add(chat);
  //   } on Exception catch (e, s) {
  //     await FirebaseCrashlytics.instance.recordError(e, s);
  //   }
  // }

  /// [AppChatItem]を[AppTodoItem]に変換する
  ///
  /// Chatのmessageをtitleに変換する。
  Future<void> convertToTodo({
    required String chatId,
  }) async {
    final user = ref.read(userControllerProvider).requireValue;
    final chat = state.value!.firstWhereOrNull((e) => e.id == chatId);
    if (chat == null || chat is! AppChatItem) {
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
      final tmp = [...state.value!];
      final index = tmp.indexWhere((element) => element.id == chat.id);
      if (index != -1) {
        tmp[index] = convertedTodo;
      }
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
