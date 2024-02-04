import 'dart:async';

import 'package:quick_flutter/systems/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_provider.g.dart';

@Riverpod(keepAlive: true)
class Memo extends _$Memo {
  Timer? _debounceTimer;

  @override
  FutureOr<String> build() async {
    ref.onDispose(() {
      print("buildbuld");
      _debounceTimer?.cancel();
    });

    final firestore = ref.read(firestoreProvider);
    // 仮としてuseridを指定
    final result = await firestore.collection("memo").doc("userid").get();
    final content = result.data()?["content"] as String?;
    return content ?? "";
  }

  Future<void> updateContent(String content) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final firestore = ref.read(firestoreProvider);
      // 仮としてuseridを指定
      await firestore.collection("memo").doc("userid").set({
        "content": content,
      });

      // state = AsyncValue.data(content);
    });
  }
}
