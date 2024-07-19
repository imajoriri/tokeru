import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
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
  Future<DateTime?> fetch() async {
    final doc = ref.read(userDocumentProvider(userId));
    final snapshot = await doc.get();
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null || !data.containsKey(_readAt)) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(data[_readAt] as int);
  }

  /// 既読時刻を更新する。
  Future<void> update(DateTime readAt) async {
    final doc = ref.read(userDocumentProvider(userId));
    await doc.update({_readAt: readAt.millisecondsSinceEpoch});
  }
}
