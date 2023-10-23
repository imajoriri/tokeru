import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:native_shared_preferences/original_shared_preferences/original_shared_preferences.dart';

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

final memosProvider = StateProvider<List<String>>((ref) {
  return [];
});

final bookmarkProvider = StateProvider<List<String>>((ref) {
  return [];
});

Future<void> saveStringList(
    {required String key, required List<String> values}) async {
  final prefs = await SharedPreferences.getInstance();

  // Stringの配列をJSON形式の文字列にエンコード
  final jsonString = jsonEncode(values);

  prefs.setString(key, jsonString);
}

Future<List<String>> getStringList({
  required String key,
}) async {
  final prefs = await SharedPreferences.getInstance();

  // JSON形式の文字列を取得してStringの配列にデコード
  final jsonString = prefs.getString(key);
  if (jsonString != null) {
    return List<String>.from(jsonDecode(jsonString));
  }
  return [];
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});
  final String bookmarkKey = "bookmark_key";

  void addBookmark(WidgetRef ref, String memo) {
    final bookmarks = ref.read(bookmarkProvider);
    final newBookmarks = [...bookmarks, memo];
    ref.read(bookmarkProvider.notifier).state = newBookmarks;
    saveStringList(key: bookmarkKey, values: newBookmarks);
  }

  void removeBookmark(WidgetRef ref, int index) {
    final bookmarks = ref.read(bookmarkProvider);
    final newBookmarks = [...bookmarks];
    newBookmarks.removeAt(index);
    ref.read(bookmarkProvider.notifier).state = newBookmarks;
    saveStringList(key: bookmarkKey, values: newBookmarks);
  }

  void addMessage(
      WidgetRef ref, TextEditingController textController, List<String> memos) {
    final newMemos = [...memos, textController.text];
    ref.read(memosProvider.notifier).state = newMemos;
    textController.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focus = useFocusNode();
    final memos = ref.watch(memosProvider);
    final bookmarks = ref.watch(bookmarkProvider);

    useEffect(() {
      getStringList(key: bookmarkKey).then((value) {
        ref.read(bookmarkProvider.notifier).state = value;
      });
    }, []);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          removeBookmark(ref, index);
                        },
                        icon: const Icon(
                          Icons.bookmark,
                          color: Colors.deepPurple,
                        )),
                    Text(bookmarks[index]),
                  ],
                );
              },
              itemCount: bookmarks.length,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              ref.read(memosProvider.notifier).state = [];
            },
            child: const Text("reset"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            addBookmark(ref, memos[index]);
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.grey,
                          )),
                      Text(memos[index]),
                    ],
                  );
                },
                itemCount: memos.length,
              ),
            ),
          ),
          MultiKeyBoardShortcuts(
            onCommandEnter: () {
              if (!focus.hasFocus) {
                return;
              }
              addMessage(ref, textController, memos);
            },
            onEsc: () {
              if (!focus.hasFocus) {
                return;
              }
              focus.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: textController,
                      focusNode: focus,
                      autofocus: true,
                    ),
                  ),
                  SubmitButton(
                      text: "add memo",
                      onTap: () {
                        addMessage(ref, textController, memos);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

class CommandEnterIntent extends Intent {}

class EscIntent extends Intent {}

class MultiKeyBoardShortcuts extends StatelessWidget {
  const MultiKeyBoardShortcuts({
    super.key,
    required this.onCommandEnter,
    required this.onEsc,
    required this.child,
  });

  final VoidCallback onCommandEnter;
  final VoidCallback onEsc;
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
          LogicalKeyboardKey.escape,
        ): EscIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          CommandEnterIntent: CallbackAction(
            onInvoke: (intent) {
              onCommandEnter();
              return null;
            },
          ),
          EscIntent: CallbackAction(
            onInvoke: (intent) {
              onEsc();
              return null;
            },
          ),
        },
        child: child,
      ),
    );
  }
}
