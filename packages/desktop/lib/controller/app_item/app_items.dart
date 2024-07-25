import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/scheduler.dart';
import 'package:tokeru_desktop/controller/refresh/refresh_controller.dart';
import 'package:tokeru_desktop/controller/user/user_controller.dart';
import 'package:tokeru_desktop/model/app_item/app_item.dart';
import 'package:tokeru_desktop/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'app_items.g.dart';

@riverpod
class AppItems extends _$AppItems {
  @override
  FutureOr<List<AppItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    final repository =
        ref.read(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.query;

    final documents = ref.watch(_appItemsPaginationProvider(query));
    final items = documents.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      final appItem = AppItem.fromJson(data..['id'] = doc.id);
      return appItem;
    }).toList();

    // nullを除外。
    return items.whereType<AppItem>().toList();
  }

  void fetchNext() {
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return;
    }
    final repository =
        ref.read(appItemRepositoryProvider(user.requireValue.id));
    final query = repository.query;
    ref.read(_appItemsPaginationProvider(query).notifier).loadDocuments();
  }

  Future<void> addChat({
    required String message,
  }) async {
    final chat = AppChatItem(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
    );
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(chat);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}

const _perPage = 40;

@riverpod
class _AppItemsPagination extends _$AppItemsPagination {
  StreamSubscription<QuerySnapshot>? _streamSub;
  StreamSubscription<QuerySnapshot>? _liveStreamSub;
  bool _isFetching = false;
  bool _isInitialLoading = true;
  bool _isEnded = false;

  @override
  List<DocumentSnapshot> build(Query<Map<String, dynamic>> query) {
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadDocuments();
    });

    return [];
  }

  Future<void> loadDocuments({
    bool getMore = true,
  }) async {
    if (_isFetching || _isEnded) return;
    if (getMore) _isFetching = true;
    final tempSub = _streamSub;

    final docsLimit = state.length + (getMore ? _perPage : 0);
    var docsQuery = query.limit(docsLimit);
    if (state.isNotEmpty) {
      docsQuery = docsQuery.startAtDocument(state.first);
    }

    _streamSub = docsQuery.snapshots().listen((QuerySnapshot snapshot) async {
      await tempSub?.cancel();

      state = snapshot.docs;

      _isFetching = false;

      // To set new updates listener for the existing data
      // or to set new live listener if the first document is removed.
      final isDocRemoved = snapshot.docChanges.any(
        (DocumentChange change) => change.type == DocumentChangeType.removed,
      );

      if (!isDocRemoved) {
        _isEnded = snapshot.docs.length < docsLimit;
      }

      if (isDocRemoved || _isInitialLoading) {
        _isInitialLoading = false;
        if (snapshot.docs.isNotEmpty) {
          // Set updates listener for the existing data starting from the first
          // document only.
          // TODO: なぜ読んでいるかわからない。初回で2回呼ばれてしまう。
          await loadDocuments(getMore: false);
        } else {
          _streamSub?.cancel();
        }
        _setLiveListener(query);
      }
    });
  }

  /// Sets the live listener for the query.
  ///
  /// Fires when new data is added to the query.
  Future<void> _setLiveListener(Query<Map<String, dynamic>> query) async {
    // To cancel previous live listener when new one is set.
    final tempSub = _liveStreamSub;

    var latestDocQuery = query.limit(1);
    if (state.isNotEmpty) {
      latestDocQuery = latestDocQuery.endBeforeDocument(state.first);
    }

    _liveStreamSub =
        latestDocQuery.snapshots(includeMetadataChanges: true).listen(
      (QuerySnapshot snapshot) async {
        await tempSub?.cancel();
        if (snapshot.docs.isEmpty ||
            snapshot.docs.first.metadata.hasPendingWrites) return;

        state = [snapshot.docs.first, ...state];

        // To handle newly added data after this curently loaded data.
        await _setLiveListener(query);

        // Set updates listener for the newly added data.
        loadDocuments(getMore: false);
      },
    );
  }
}
