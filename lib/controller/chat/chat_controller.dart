import 'package:quick_flutter/model/chat/chat.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

const cacheTime = Duration(hours: 5);

/// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
///
/// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<List<Chat>> build(String todoId) async {
    return [
      Chat(
        id: '1',
        todoId: todoId,
        body: 'Hello',
        createdAt: DateTime.now(),
      ),
      Chat(
        id: '2',
        todoId: todoId,
        body: 'World',
        createdAt: DateTime.now(),
      ),
    ];
  }
}
