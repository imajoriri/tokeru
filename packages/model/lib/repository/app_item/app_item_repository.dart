import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tokeru_model/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';

part 'app_item_repository.g.dart';

const _collectionName = 'todos';

// TODO: リファクタリング
// - typeがAppItemのtypeを参照したい。
// - AppItemのサブクラスごとにリポジトリを分けたい。
// - userIdをメソッドごとに受け取りたい。

/// [AppItem]を扱うRepository
@riverpod
AppItemRepository appItemRepository(AppItemRepositoryRef ref, String userId) =>
    AppItemRepository(ref: ref, userId: userId);

class AppItemRepository {
  AppItemRepository({
    required this.ref,
    required this.userId,
  });
  final Ref ref;
  final String userId;

  /// [AppItem.id]から[AppItem]を取得する。
  Future<AppItem?> fetchById({
    required String userId,
    required String id,
  }) async {
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .get();
    if (!response.exists) {
      return null;
    }
    return AppItem.fromJson(response.data()!..['id'] = response.id);
  }

  /// [AppItem]のクエリを返す。
  Query<Map<String, dynamic>> chatQuery({
    required String userId,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(_collectionName)
        .where('type', isEqualTo: 'chat')
        .limit(50)
        .orderBy('createdAt', descending: true);
  }

  /// スレッドのクエリを返す。
  Query<Map<String, dynamic>> threadQuery({
    required String userId,
    required String parentId,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(_collectionName)
        .where('type', isEqualTo: 'thread')
        .where('parentId', isEqualTo: parentId)
        .orderBy('createdAt', descending: true);
  }

  Query<Map<String, dynamic>> todoQuery({
    required String userId,
    bool isDone = false,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(_collectionName)
        .where('isDone', isEqualTo: isDone)
        .where('type', isEqualTo: 'todo');
  }

  Future<List<AppTodoItem>> fetchTodos({
    bool isDone = false,
  }) {
    // NOTE: ここでorderBy indexをすると、intではなく文字列でソートされてしまう。
    final response = ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .where('isDone', isEqualTo: isDone)
        .where('type', isEqualTo: 'todo')
        .get();

    return response.then((snapshot) {
      return snapshot.docs.map((doc) {
        return AppTodoItem.fromJson(doc.data()..['id'] = doc.id);
      }).toList();
    });
  }

  /// [AppItem]を追加する。
  Future<AppItem> add(AppItem item) async {
    final json = item.toJson();
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(item.id)
        .set(json);
    return item;
  }

  /// [AppItem]を複数追加する。
  Future<void> addAll(List<AppItem> items) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();
    for (final item in items) {
      final json = item.toJson();
      batch.set(
        ref
            .read(userDocumentProvider(userId))
            .collection(_collectionName)
            .doc(item.id),
        json,
      );
    }
    await batch.commit();
  }

  Future<void> update<T extends AppItem>({
    required T item,
  }) async {
    final json = item.toJson();
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(item.id)
        .update(json);
  }

  /// スレッドの件数を+1する。
  Future<void> incrementThreadCount({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .update({
      'threadCount': FieldValue.increment(1),
    });
  }

  /// Todoを削除する
  Future<void> delete({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .delete();
  }

  /// 並び順を更新する
  ///
  /// [todos]の順番で 'index' を一気に更新する
  Future<void> updateTodoOrder({required List<AppTodoItem> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection(_collectionName)
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }
    await batch.commit();
  }

  /// 追加とソートを同時に行う。
  Future<void> addAndUpdateOrder(
      {required AppTodoItem addedTodo,
      required List<AppTodoItem> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    // todoを追加する。
    batch.set(
      ref
          .read(userDocumentProvider(userId))
          .collection(_collectionName)
          .doc(addedTodo.id),
      addedTodo.toJson(),
    );

    // 並び順を更新する。
    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection(_collectionName)
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }

    await batch.commit();
  }
}
