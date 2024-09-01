import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'threads.g.dart';

@riverpod
class Threads extends _$Threads {
  late ChatSession chatSession;

  @override
  Stream<List<AppItem>> build(String parentId) {
    ref.watch(refreshControllerProvider);

    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    final repository =
        ref.watch(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.query(
      userId: user.requireValue.id,
      type: const ['thread', 'ai_comment'],
      parentId: parentId,
    );

    final result = query.snapshots().map((snapshot) {
      final items = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data == null) {
              return null;
            }

            final appItem = AppItem.fromJson(data..['id'] = doc.id);
            return appItem;
          })
          // nullを除外。
          .whereType<AppItem>()
          .toList();
      return items;
    });
    return result;
  }

  /// チャットを追加する。
  Future<void> add({
    required String message,
  }) async {
    final tread = AppThreadItem(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
      parentId: parentId,
    );

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(tread);
      // スレッド件数を更新する。
      await repository.incrementThreadCount(id: parentId);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
