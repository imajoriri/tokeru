import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/controller/read/read_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_all_controller.g.dart';

/// 全てのチャットを既読したかどうかを管理するコントローラー。
@riverpod
Future<bool> readAll(ReadAllRef ref) async {
  final appItems = await ref.watch(chatsProvider.future);
  final latestAppItem = appItems.firstOrNull;
  // チャットがない場合はfalseを返す。
  if (latestAppItem == null) {
    return false;
  }

  final readAt = await ref.watch(readControllerProvider.future);

  if (readAt == null) {
    return false;
  }

  // 最後のチャットが既読されているかどうか。
  return latestAppItem.createdAt.isBefore(readAt);
}
