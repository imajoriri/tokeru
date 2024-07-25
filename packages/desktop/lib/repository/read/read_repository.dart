import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_repository.g.dart';

const _readAt = 'readAt';

@riverpod
ReadRepository readRepository(ReadRepositoryRef ref, String userId) =>
    ReadRepository(ref: ref, userId: userId);

class ReadRepository {
  ReadRepository({
    required this.ref,
    required this.userId,
  });
  final Ref ref;
  final String userId;

  /// 最終既読時刻を取得する。
  Stream<DateTime?> fetch() {
    final doc = ref.read(userDocumentProvider(userId));
    final snapshot = doc.snapshots();
    return snapshot.map((event) {
      final data = event.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey(_readAt)) {
        return null;
      }

      return DateTime.fromMillisecondsSinceEpoch(data[_readAt] as int);
    });
  }

  /// 既読時刻を更新する。
  Future<void> update(DateTime readAt) async {
    final doc = ref.read(userDocumentProvider(userId));
    await doc.update({_readAt: readAt.millisecondsSinceEpoch});
  }
}
