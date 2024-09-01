import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generative_sub_todo.g.dart';

@riverpod
class GenerativeSubTodo extends _$GenerativeSubTodo {
  final exchangeRateTool = FunctionDeclaration(
    'generateSubTodo',
    'Returns sub tasks for the parent task.',
    Schema(
      SchemaType.object,
      properties: {
        'parentTodoTitle': Schema(SchemaType.string,
            description: 'The title of the parent task.'),
        'subTodos': Schema(SchemaType.array,
            description: 'The sub tasks for the parent task.'),
      },
      requiredProperties: ['parentTodoTitle', 'subTodos'],
    ),
  );

  late final ChatSession chat;

  @override
  FutureOr<List<String>> build({
    required String parentTodoTitle,
  }) async {
    final model = FirebaseVertexAI.instanceFor(
      auth: FirebaseAuth.instance,
      app: Firebase.app(),
    ).generativeModel(
      model: 'gemini-1.5-flash',
      tools: [
        Tool(functionDeclarations: [exchangeRateTool]),
      ],
    );
    chat = model.startChat();
    return [];
  }

  Future<void> generateSubTodo() async {
    final message =
        '$parentTodoTitleを完了するための具体的なサブタスクを作成してください。サブタスクはそれぞれ30文字以内でお願いします。';
    final prompt = Content.text(message);
    var response = await chat.sendMessage(prompt);

    final functionCalls = response.functionCalls.toList();
    if (functionCalls.isNotEmpty) {
      final functionCall = functionCalls.first;
      final result = switch (functionCall.name) {
        'generateSubTodo' => await _generateSubTodo(functionCall.args),
        _ => throw UnimplementedError(
            'Function not implemented: ${functionCall.name}')
      };
      final subTodos = result['subTodos'] as List<String>;
      state = AsyncValue.data(subTodos);
    }
  }

  Future<void> regenerate() async {}

  void clear() {
    state = const AsyncValue.data([]);
  }
}

Future<Map<String, Object?>> _generateSubTodo(
  Map<String, Object?> arguments,
) async {
  final subTodos = (arguments['subTodos'] as List<dynamic>).cast<String>();
  return {
    'parentTodoTitle': arguments['parentTodoTitle'],
    'subTodos': subTodos,
  };
}
