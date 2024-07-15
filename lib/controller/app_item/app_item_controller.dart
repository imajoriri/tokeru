// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
