import 'dart:async';

import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_controller.g.dart';

@Riverpod(keepAlive: true)
class MemoController extends _$MemoController {
  Timer? _debounceTimer;

  @override
  FutureOr<String> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    final firestore = ref.read(firestoreProvider);
    // 仮としてuseridを指定
    final result = await firestore.collection("memo").doc("userid").get();
    final content = result.data()?["deltaJson"] as String?;
    return content ?? "";
  }

  Future<void> updateContent(String deltaJson) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final firestore = ref.read(firestoreProvider);
      // 仮としてuseridを指定
      await firestore.collection("memo").doc("userid").set({
        "deltaJson": deltaJson,
      });

      state = AsyncValue.data(deltaJson);
    });
  }
}
