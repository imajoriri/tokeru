import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:uuid/uuid.dart';

part 'generative_ai.g.dart';

@riverpod
GenerativeAi generativeAi(GenerativeAiRef ref) {
  return GoogleGenerativeAI();
}

abstract class GenerativeAi {
  /// サブタスクを生成する。
  Future<List<AppSubTodoItem>> generateSubTodo({
    required String parentTodoTitle,
    required String parentTodoId,
  });
}

class GoogleGenerativeAI extends GenerativeAi {
  @override
  Future<List<AppSubTodoItem>> generateSubTodo({
    required String parentTodoTitle,
    required String parentTodoId,
  }) async {
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
    final model = FirebaseVertexAI.instanceFor(
      auth: FirebaseAuth.instance,
      app: Firebase.app(),
    ).generativeModel(
      model: 'gemini-1.5-flash',
      tools: [
        Tool(functionDeclarations: [exchangeRateTool]),
      ],
    );
    final chatSession = model.startChat();
    final message =
        '$parentTodoTitleを完了するための具体的なサブタスクを作成してください。サブタスクはそれぞれ30文字以内でお願いします。';
    final prompt = Content.text(message);
    var response = await chatSession.sendMessage(prompt);

    final functionCalls = response.functionCalls.toList();
    final functionCall = functionCalls.first;
    if (functionCalls.isNotEmpty) {
      final result = switch (functionCall.name) {
        'generateSubTodo' => await _generateSubTodo(functionCall.args),
        _ => throw UnimplementedError(
            'Function not implemented: ${functionCall.name}')
      };
      final subTodos = result['subTodos'] as List<String>;
      return subTodos
          .map(
            (e) => AppSubTodoItem(
              title: e,
              id: const Uuid().v4(),
              parentId: parentTodoId,
              isDone: false,
              index: 0,
              createdAt: DateTime.now(),
            ),
          )
          .toList();
    }

    return [];
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
