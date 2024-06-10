import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/chat/chat.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref, String userId) =>
    ChatRepository(ref: ref, userId: userId);

class ChatRepository {
  final Ref ref;
  final String userId;

  ChatRepository({
    required this.ref,
    required this.userId,
  });

  /// [todoId]に紐づく[Chat]のリストを取得する。
  Future<List<Chat>> fetchChats(String todoId) async {
    final doc = ref
        .read(userDocumentProvider(userId))
        .collection('chats')
        .where('todoId', isEqualTo: todoId)
        .orderBy('createdAt', descending: true);
    final response = await doc.get();
    return (response.docs.map((doc) {
      return Chat.fromJson(doc.data()..['id'] = doc.id);
    }).toList());
  }

  /// 全ての[Chat]のリストを取得する。
  Future<List<Chat>> fetchAllChats() async {
    final doc = ref
        .read(userDocumentProvider(userId))
        .collection('chats')
        .orderBy('createdAt', descending: true);
    final response = await doc.get();
    return (response.docs.map((doc) {
      return Chat.fromJson(doc.data()..['id'] = doc.id);
    }).toList());
  }

  /// [Chat]を追加する。
  Future<Chat> addChat({
    required String? todoId,
    required String body,
    required DateTime createdAt,
  }) async {
    final chat = Chat(
      id: '',
      todoId: todoId,
      body: body,
      createdAt: createdAt,
    );
    final json = chat.toJson();
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection('chats')
        .add(json);

    return chat.copyWith(id: response.id);
  }
}
