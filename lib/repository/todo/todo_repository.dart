import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_repository.g.dart';

/// [TodoItem]を扱うRepository
@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref, String userId) =>
    TodoRepository(ref: ref, userId: userId);

class TodoRepository {
  TodoRepository({
    required this.ref,
    required this.userId,
  });
  final Ref ref;
  final String userId;

  /// 指定した日付より後に作成されたTodoを取得する
  Future<List<TodoItem>> fetchTodosAfter({
    required DateTime date,
    bool isDone = false,
    int limit = 50,
  }) async {
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection('todos')
        .where('isDone', isEqualTo: isDone)
        .where('createdAt', isGreaterThan: date)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return (response.docs.map((doc) {
      return TodoItem.fromJson(doc.data()..['id'] = doc.id);
    }).toList());
  }

  /// 指定した日付より前に作成されたTodoを取得する
  Future<List<TodoItem>> fetchTodosBefore({
    required DateTime date,
    bool isDone = false,
    int limit = 50,
  }) async {
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection('todos')
        .where('isDone', isEqualTo: isDone)
        .where('createdAt', isLessThan: date)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return (response.docs.map((doc) {
      return TodoItem.fromJson(doc.data()..['id'] = doc.id);
    }).toList());
  }

  /// [Todo]を追加し、[TodoItem]として返す。
  Future<TodoItem> add({
    String title = '',
    bool isDone = false,
    int indentLevel = 0,
    int index = 0,
  }) async {
    final createdAt = DateTime.now();
    final todo = TodoItem.todo(
      id: '',
      title: title,
      isDone: isDone,
      indentLevel: indentLevel,
      index: index,
      createdAt: createdAt,
    );
    final json = todo.toJson();
    final res = await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .add(json);
    return todo.copyWith(id: res.id);
  }

  /// Todoを更新する
  Future<void> update({
    required String id,
    String? title,
    bool? isDone,
    int? indentLevel,
    int? index,
  }) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(id)
        .update({
      if (title != null) 'title': title,
      if (isDone != null) 'isDone': isDone,
      if (indentLevel != null) 'indentLevel': indentLevel,
      if (index != null) 'index': index,
    });
  }

  /// Todoを削除する
  Future<void> delete({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(id)
        .delete();
  }

  /// 並び順を更新する
  ///
  /// [todos]の順番で 'index' を一気に更新する
  Future<void> updateOrder({required List<TodoItem> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection("todos")
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }
    await batch.commit();
  }
}
