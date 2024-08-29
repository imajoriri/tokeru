import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      _setChatSession(parentId, items.whereType<AppAiCommentItem>().toList());
      return items;
    });
    return result;
  }

  void _setChatSession(String parentId, List<AppAiCommentItem> histories) {
    final system = '''
あなたはユーザーのタスクのサポートをするために、ユーザーの発散した内容を整理し、タスクのサポートをすることができます。
今回のタスクは`title`です。
    ''';

    final history = histories
        .map((e) => [
              Content.text(e.userMessage),
              Content.model([TextPart(e.aiMessage)]),
            ])
        .toList()
        .expand((e) => e)
        .toList();
    chatSession = FirebaseVertexAI.instanceFor(
      auth: FirebaseAuth.instance,
      app: Firebase.app(),
    )
        .generativeModel(
          model: 'gemini-1.5-flash',
          systemInstruction: Content.system(system),
        )
        .startChat(
          history: history,
        );
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

  /// AIにメッセージを送信する。
  // ignore: unused_element
  Future<void> _sendMessageToAi(String message) async {
    final prompt = Content.text(message);
    final response = await chatSession.sendMessage(prompt);
    final aiComment = AppAiCommentItem(
      id: const Uuid().v4(),
      userMessage: message,
      aiMessage: response.text ?? '',
      parentId: parentId,
      createdAt: DateTime.now(),
    );
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(aiComment);
      // スレッド件数を更新する。
      await repository.incrementThreadCount(id: parentId);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
