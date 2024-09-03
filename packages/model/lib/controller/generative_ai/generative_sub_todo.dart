import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'generative_sub_todo.g.dart';

@riverpod
class GenerativeSubTodo extends _$GenerativeSubTodo {
  final generateSubTodoFunction = FunctionDeclaration(
    'generateSubTodo',
    'Returns sub tasks for the parent task.',
    Schema(
      SchemaType.object,
      properties: {
        'parentTodoTitle': Schema(
          SchemaType.string,
          description: 'The title of the parent task.',
        ),
        'subTodos': Schema(
          SchemaType.array,
          description: 'The sub tasks for the parent task.',
        ),
      },
      requiredProperties: [
        'parentTodoTitle',
        'subTodos',
      ],
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
        Tool(functionDeclarations: [generateSubTodoFunction]),
      ],
      systemInstruction: Content.text(
        '''
あなたは特定のタスクを実行しやすくするためにサブタスクを生成するアシスタントです。
Flutterエンジニアのサブタスクを想定して生成してください。
なるべく具体的なサブタスクを生成してください。
サブタスクは全て「〜〜する」のような動詞で生成してください。
        ''',
      ),
    );
    chat = model.startChat();
    return [];
  }

  Future<void> generateSubTodo() async {
    final message = parentTodoTitle;
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

  void reject() {
    state = const AsyncValue.data([]);
  }

  /// 生成されたサブタスクを保存する。
  Future<void> accept({
    required String parentId,
  }) async {
    final subTodos = state.requireValue
        .map(
          (e) => AppSubTodoItem(
            id: const Uuid().v4(),
            createdAt: DateTime.now(),
            title: e,
            isDone: false,
            index: 0,
            parentId: parentId,
          ),
        )
        .toList();
    final user = ref.watch(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));

    try {
      await repository.addAll(subTodos);
      await repository.incrementSubTodoCount(
        id: parentId,
        count: subTodos.length,
      );
      state = const AsyncValue.data([]);
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
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
