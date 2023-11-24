import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/store/note_store.dart';

class MainMemoScreen extends HookConsumerWidget {
  const MainMemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(noteStoreProvider.notifier);
    final textControllers = useState(<TextEditingController>[]);

    ref.listen(noteStoreProvider, (previous, next) {
      // コンテンツ数が変わった時は、テキストコントローラーを更新する
      if (previous?.valueOrNull?.length != next.valueOrNull?.length) {
        textControllers.value =
            List.generate(next.valueOrNull?.length ?? 0, (index) {
          return DebouncingTextEditingController(
              text: next.valueOrNull?[index].content,
              onDebouncedTextChange: (value) {
                controller.updateNote(
                  noteId:
                      ref.read(noteStoreProvider).valueOrNull?[index].id ?? "",
                  content: value,
                );
              });
        });
        return;
      }

      // TODO: debounceするとcontentがかわちゃってバグる
      // コンテンツ数が変わらず、中身のテキストが変わった場合、変わったものだけを更新する
      // (編集中のテキストが更新されないようにするため)
      // for (var i = 0; i < (next.valueOrNull?.length ?? 0); i++) {
      //   if (previous?.valueOrNull?[i].content != next.valueOrNull?[i].content) {
      //     textControllers.value[i].text = next.valueOrNull?[i].content ?? '';
      //   }
      // }
    });

    // dispose
    useEffect(() {
      return () {
        for (final c in textControllers.value) {
          c.dispose();
        }
      };
    }, []);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(textControllers.value.length.toString()),
                const SizedBox(width: 12),
                ElevatedButton(
                    onPressed: () {
                      controller.clearAndAdd();
                    },
                    child: const Text("clear")),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(
              textControllers.value.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textControllers.value[index],
                          maxLines: null,
                        ),
                      ),
                      // 削除アイコンボタン
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          final notes = ref.read(noteStoreProvider);
                          ref.read(noteStoreProvider.notifier).remove(
                                notes.valueOrNull?[index].id ?? "",
                              );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () {
                  ref.read(noteStoreProvider.notifier).add();
                },
                child: const Text("add")),
          ],
        ),
      ),
    );
  }
}

class DebouncingTextEditingController extends TextEditingController {
  DebouncingTextEditingController({
    String? text,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onDebouncedTextChange,
  }) : super(text: text) {
    addListener(_onTextChange);
  }

  final Duration debounceDuration;
  Timer? _debounceTimer;

  void Function(String)? onDebouncedTextChange;

  void _onTextChange() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, () {
      onDebouncedTextChange?.call(text);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    removeListener(_onTextChange);
    super.dispose();
  }
}
