import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_item_repository.g.dart';

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

  /// 指定した日付より後に作成された[AppItem]を取得する
  ///
  /// - [limit]: 取得するTodoの最大数
  /// - [start]: この日付より後に作成された[AppItem]を取得する
  /// - [end]: この日付より前に作成された[AppItem]を取得する
  /// - [type]: 取得する[AppItem]のタイプ
  /// - [isDone]: 取得する[AppItem]のisDone
  Future<List<AppItem>> fetch({
    int limit = 50,
    DateTime? start,
    DateTime? end,
    String? type,
    bool? isDone,
  }) async {
    var doc = ref
        .read(userDocumentProvider(userId))
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .limit(limit);
    if (start != null) {
      doc = doc.where('createdAt', isGreaterThan: start);
    }
    if (end != null) {
      doc = doc.where('createdAt', isLessThan: end);
    }
    if (type != null) {
      doc = doc.where('type', isEqualTo: type);
    }
    if (isDone != null) {
      doc = doc.where('isDone', isEqualTo: isDone);
    }
    final response = await doc.get();
    return (response.docs.map((doc) {
      return AppItem.fromJson(doc.data()..['id'] = doc.id);
    }).toList());
  }

  /// [AppTodoItem]を追加する。
  Future<AppTodoItem> addTodo({
    required DateTime createdAt,
    String title = '',
    bool isDone = false,
    int index = 0,
  }) async {
    final todo = AppTodoItem(
      id: '',
      title: title,
      isDone: isDone,
      index: index,
      createdAt: createdAt,
    );
    final res = await _add(todo);
    return todo.copyWith(id: res.id);
  }

  /// [AppChatItem]を追加する。
  Future<AppChatItem> addChat({
    required AppChatItem chat,
  }) async {
    final json = chat.toJson()..remove('id');
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(chat.id)
        .set(json);
    return chat;
  }

  /// [AppItem]を追加する。
  Future<AppItem> _add(AppItem item) async {
    final json = item.toJson();
    final res = await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .add(json);
    return item.copyWith(id: res.id);
  }

  Future<void> update<T extends AppItem>({
    required T item,
  }) async {
    final json = item.toJson();
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(item.id)
        .update(json);
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
  Future<void> updateTodoOrder({required List<AppTodoItem> todos}) async {
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
