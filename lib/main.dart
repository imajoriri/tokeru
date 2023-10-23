import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
void panel() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

enum SubmitButtonType {
  todos,
  memo,
}

final submitButtonTypeProvider = StateProvider<SubmitButtonType>((ref) {
  return SubmitButtonType.todos;
});

final memosProvider = StateProvider<List<String>>((ref) {
  return [];
});

final todosProvider = StateProvider<List<String>>((ref) {
  return [];
});

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  void addTodo(
      WidgetRef ref, TextEditingController textController, List<String> todos) {
    ref.read(submitButtonTypeProvider.notifier).state = SubmitButtonType.todos;
    ref.read(todosProvider.notifier).state = [...todos, textController.text];
    textController.clear();
  }

  void addMessage(
      WidgetRef ref, TextEditingController textController, List<String> memos) {
    ref.read(submitButtonTypeProvider.notifier).state = SubmitButtonType.memo;
    ref.read(memosProvider.notifier).state = [...memos, textController.text];
    textController.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focus = useFocusNode();
    final submitButtonType = ref.watch(submitButtonTypeProvider);
    final memos = ref.watch(memosProvider);
    final todos = ref.watch(todosProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Text(todos[index]);
                    },
                    itemCount: todos.length,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Text(memos[index]);
                    },
                    itemCount: memos.length,
                  ),
                ),
              ],
            ),
          ),
          MultiKeyBoardShortcuts(
            onCommandLeftArrow: () {
              ref.read(submitButtonTypeProvider.notifier).state =
                  SubmitButtonType.todos;
            },
            onCommandRightArrow: () {
              ref.read(submitButtonTypeProvider.notifier).state =
                  SubmitButtonType.memo;
            },
            onCommandEnter: () {
              if (!focus.hasFocus) {
                return;
              }
              if (submitButtonType == SubmitButtonType.todos) {
                addTodo(ref, textController, todos);
              } else {
                addMessage(ref, textController, memos);
              }
            },
            child: Row(
              children: [
                SubmitButton(
                    text: "add todo",
                    canSubmit: submitButtonType == SubmitButtonType.todos,
                    onTap: () {
                      addTodo(ref, textController, todos);
                    }),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: textController,
                    focusNode: focus,
                  ),
                ),
                SubmitButton(
                    text: "add memo",
                    canSubmit: submitButtonType == SubmitButtonType.memo,
                    onTap: () {
                      addMessage(ref, textController, memos);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key,
      required this.text,
      required this.canSubmit,
      required this.onTap});

  final bool canSubmit;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            canSubmit ? Colors.deepPurple : Colors.transparent),
      ),
      child: Text(text,
          style: TextStyle(color: canSubmit ? Colors.white : Colors.grey)),
    );
  }
}

class CommandEnterIntent extends Intent {}

class CommandRightArrowIntent extends Intent {}

class CommandLeftArrowIntent extends Intent {}

class MultiKeyBoardShortcuts extends StatelessWidget {
  const MultiKeyBoardShortcuts({
    super.key,
    required this.onCommandEnter,
    required this.onCommandRightArrow,
    required this.onCommandLeftArrow,
    required this.child,
  });

  final VoidCallback onCommandEnter;
  final VoidCallback onCommandRightArrow;
  final VoidCallback onCommandLeftArrow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.enter,
        ): CommandEnterIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.arrowRight,
        ): CommandRightArrowIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.arrowLeft,
        ): CommandLeftArrowIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          CommandEnterIntent: CallbackAction(
            onInvoke: (intent) {
              onCommandEnter();
              return null;
            },
          ),
          CommandRightArrowIntent: CallbackAction(
            onInvoke: (intent) {
              onCommandRightArrow();
              return null;
            },
          ),
          CommandLeftArrowIntent: CallbackAction(
            onInvoke: (intent) {
              onCommandLeftArrow();
              return null;
            },
          ),
        },
        child: child,
      ),
    );
  }
}
