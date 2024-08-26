part of 'app_item_repository.dart';

extension AppTodoItemRepository on AppItemRepository {
  /// 並び順を更新する
  ///
  /// [todos]の順番で 'index' を一気に更新する
  Future<void> updateTodoOrder({
    required String userId,
    required List<AppTodoItem> todos,
  }) async {
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
  Future<void> addAndUpdateOrder({
    required String userId,
    required AppTodoItem addedTodo,
    required List<AppTodoItem> todos,
  }) async {
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

  /// サブTodoの件数を+1する。
  Future<void> incrementSubTodoCount({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .update({
      'subTodoCount': FieldValue.increment(1),
    });
  }

  /// サブTodoの件数を-1する。
  Future<void> decrementSubTodoCount({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .update({
      'subTodoCount': FieldValue.increment(-1),
    });
  }
}
