import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/repository/read/read_repository.dart';

part 'read_controller.g.dart';

/// Todoの既読した時刻を管理するコントローラー。
@riverpod
class ReadController extends _$ReadController {
  @override
  Stream<DateTime?> build() {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    return ref.watch(readRepositoryProvider(user.value!.id)).fetch();
  }

  Future<void> markAsRead(DateTime readAt) async {
    // 既読した時刻を更新する。
    state = AsyncValue.data(readAt);

    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return;
    }

    await ref.watch(readRepositoryProvider(user.value!.id)).update(readAt);
  }
}
