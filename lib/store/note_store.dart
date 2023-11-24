import 'package:quick_flutter/model/note.dart';
import 'package:quick_flutter/repository/note_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_store.g.dart';

@riverpod
class NoteStore extends _$NoteStore {
  @override
  FutureOr<List<Note>> build() async {
    return ref.read(noteRepositoryProvider).getAll(descending: false);
  }

  Future<void> add() async {
    final newNote = await ref.read(noteRepositoryProvider).add(content: "");
    state = AsyncValue.data([...state.valueOrNull ?? [], newNote]);
  }

  // 更新
  Future<void> updateNote(
      {required String noteId, required String content}) async {
    await ref.read(noteRepositoryProvider).update(id: noteId, content: content);
    state = AsyncValue.data([
      for (final n in state.valueOrNull ?? [])
        if (n.id == noteId)
          n.copyWith(
            content: content,
          )
        else
          n,
    ]);
  }

  // 削除
  Future<void> remove(String noteId) async {
    await ref.read(noteRepositoryProvider).remove(noteId);
    state = AsyncValue.data([
      for (final n in state.valueOrNull ?? [])
        if (n.id != noteId) n,
    ]);
  }

  // 一括削除し、1つだけから文字で追加
  Future<void> clearAndAdd() async {
    await ref.read(noteRepositoryProvider).clear();
    state = const AsyncValue.data([]);
  }
}
