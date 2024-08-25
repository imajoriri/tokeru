import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';

part 'ai.g.dart';

@riverpod
class AiChat extends _$AiChat {
  @override
  ChatSession build(AppItem appItem) {
    final system = switch (appItem) {
      AppTodoItem(title: final title) => ''''
あなたはユーザーのタスクのサポートをするために、ユーザーの発散した内容を整理し、タスクのサポートをすることができます。
今回のタスクは`$title`です。
''',
      _ => ''
    };
    return FirebaseVertexAI.instance
        .generativeModel(
            model: 'gemini-1.5-flash', systemInstruction: Content.text(system))
        .startChat();
  }

  Future<String> sendMessage(String message) async {
    final prompt = Content.text(message);
    final response = await state.sendMessage(prompt);
    return response.text ?? '';
  }
}
