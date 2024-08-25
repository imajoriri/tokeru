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
  Stream<List<AppItem>> build(AppItem parent) {
    ref.watch(refreshControllerProvider);

    _setChatSession(parent);

    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    final repository =
        ref.watch(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.query(
      userId: user.requireValue.id,
      type: const ['thread', 'ai_comment'],
      parentId: parent.id,
    );

    return query.snapshots().map((snapshot) {
      final items = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }

        final appItem = AppItem.fromJson(data..['id'] = doc.id);
        return appItem;
      }).toList();
      // nullを除外。
      return items.whereType<AppItem>().toList();
    });
  }

  void _setChatSession(AppItem parent) {
    final system = switch (parent) {
      AppTodoItem(title: final title) => ''''
あなたはユーザーのタスクのサポートをするために、ユーザーの発散した内容を整理し、タスクのサポートをすることができます。
今回のタスクは`$title`です。
    ''',
      _ => throw UnimplementedError(),
    };
    chatSession = FirebaseVertexAI.instance
        .generativeModel(
            model: 'gemini-1.5-flash', systemInstruction: Content.text(system))
        .startChat();
  }

  /// チャットを追加する。
  Future<void> add({
    required String message,
  }) async {
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

  /// AIにメッセージを送信する。
  Future<void> sendMessageToAi(String message) async {
    final prompt = Content.text(message);
    final response = await chatSession.sendMessage(prompt);
    final aiComment = AppAiCommentItem(
      id: const Uuid().v4(),
      userMessage: message,
      aiMessage: response.text ?? '',
      parentId: parent.id,
      createdAt: DateTime.now(),
    );
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(aiComment);
      // スレッド件数を更新する。
      await repository.incrementThreadCount(id: parent.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
