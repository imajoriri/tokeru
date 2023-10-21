import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focusNode = FocusNode();
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
          RawKeyboardListener(
            focusNode: focusNode,
            onKey: (value) {
              print(value);
            },
            child: Row(
              children: [
                SubmitButton(
                    text: "add todo",
                    canSubmit: submitButtonType == SubmitButtonType.todos,
                    onTap: () {
                      ref.read(submitButtonTypeProvider.notifier).state =
                          SubmitButtonType.todos;
                      ref.read(todosProvider.notifier).state = [
                        ...todos,
                        textController.text
                      ];
                      textController.clear();
                    }),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: textController,
                  ),
                ),
                SubmitButton(
                    text: "add memo",
                    canSubmit: submitButtonType == SubmitButtonType.memo,
                    onTap: () {
                      ref.read(submitButtonTypeProvider.notifier).state =
                          SubmitButtonType.memo;
                      ref.read(memosProvider.notifier).state = [
                        ...memos,
                        textController.text
                      ];
                      textController.clear();
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
