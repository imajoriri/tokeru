import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'threads.g.dart';

@riverpod
class Threads extends _$Threads {
  @override
  Stream<List<AppThreadItem>> build() {
    ref.watch(refreshControllerProvider);

    final parent = ref.watch(selectedThreadProvider);
    if (parent == null) {
      return const Stream.empty();
    }

    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    final repository =
        ref.watch(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.threadQuery(
      userId: user.requireValue.id,
      parentId: parent.id,
    );

    return query.snapshots().map((snapshot) {
      final items = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }

        final appItem = AppThreadItem.fromJson(data..['id'] = doc.id);
        return appItem;
      }).toList();

      // nullを除外。
      return items.whereType<AppThreadItem>().toList();
    });
  }

  /// チャットを追加する。
  Future<void> add({
    required String message,
  }) async {
    final parent = ref.read(selectedThreadProvider);
    if (parent == null) {
      return;
    }

    final tread = AppThreadItem(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
      parentId: parent.id,
    );

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(tread);
      // スレッド件数を更新する。
      await repository.incrementThreadCount(id: parent.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
