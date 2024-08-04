import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'threads.g.dart';

@riverpod
class Threads extends _$Threads {
  @override
  Stream<List<AppChatItem>> build({
    required String chatId,
  }) {
    ref.watch(refreshControllerProvider);

    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    final repository =
        ref.watch(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.threadQuery(
      userId: user.requireValue.id,
      chatId: chatId,
    );

    return query.snapshots().map((snapshot) {
      final items = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }

        final appItem = AppChatItem.fromJson(data..['id'] = doc.id);
        return appItem;
      }).toList();

      // nullを除外。
      return items.whereType<AppChatItem>().toList();
    });
  }

  /// チャットを追加する。
  Future<void> add({
    required String message,
  }) async {
    final chat = AppChatItem(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
      chatId: chatId,
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
