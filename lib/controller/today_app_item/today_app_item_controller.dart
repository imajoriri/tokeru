import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_app_item_controller.g.dart';

/// 今日作成された[AppItem]を返すController。
@Riverpod(keepAlive: true)
class TodayAppItemController extends _$TodayAppItemController {
  /// 1ページあたりの取得数。
  final initialPerPage = 20;

  /// 次の[AppItem]があるかどうか。
  bool hasNext = true;

  @override
  FutureOr<List<AppItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todos = await repository.fetch(
      start: todayStart.subtract(const Duration(days: 1)),
      limit: initialPerPage,
    );
    return todos;
  }

  /// 次の[AppItem]を取得する
  Future<void> fetchNext() async {
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

    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }

    state = const AsyncLoading<List<AppItem>>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final repository = ref.read(appItemRepositoryProvider(user.value!.id));
      final last = state.value!.last;
      final todos = await repository.fetch(
        end: last.createdAt,
        limit: initialPerPage,
      );
      if (todos.isEmpty) {
        hasNext = false;
      }
      return [...value, ...todos];
    });
  }

  /// [AppChatItem]を追加する
  Future<void> addChat({
    required String message,
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      final chat = await repository.addChat(
        message: message,
        createdAt: DateTime.now(),
      );
      final tmp = [...state.value!];
      tmp.insert(0, chat);
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
