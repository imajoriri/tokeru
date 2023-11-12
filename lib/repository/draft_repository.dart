import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/draft.dart';
import 'package:quick_flutter/systems/firebase_provider.dart';

final draftRepositoryProvider = Provider((ref) => DraftRepository(ref: ref));

class DraftRepository {
  DraftRepository({required this.ref});
  final Ref ref;

  /// 追加
  Future<Draft> add({required String content}) async {
    // 追加する処理
    final firestore = ref.read(firestoreProvider);
    final res = await firestore.collection("drafts").add({
      "content": content,
      "createdAt": DateTime.now(),
    });
    return Draft(
      id: res.id,
      content: content,
      createdAt: DateTime.now(),
    );
  }

  /// 更新
  Future<void> update({
    required String id,
    String? content,
  }) async {
    final firestore = ref.read(firestoreProvider);
    // null以外を更新
    final data = {
      if (content != null) "content": content,
    };
    await firestore.collection("drafts").doc(id).update(data);
  }

  /// 削除
  Future<void> delete({required String id}) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("drafts").doc(id).delete();
  }

  /// 全件取得
  Future<List<Draft>> getAll({
    bool descending = true,
  }) async {
    final firestore = ref.read(firestoreProvider);
    final response = await firestore
        .collection("drafts")
        .orderBy('createdAt', descending: descending)
        .get();
    return (response.docs.map((doc) {
      return Draft(
        id: doc.id,
        content: doc.data()['content'] ?? '',
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }
}
