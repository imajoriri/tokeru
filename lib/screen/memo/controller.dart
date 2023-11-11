import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.freezed.dart';
part 'controller.g.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  factory ChatScreenState({
    @Default([]) List<String> drafts,
  }) = _ChatScreenState;
}

@riverpod
class ChatScreenController extends _$ChatScreenController {
  @override
  FutureOr<ChatScreenState> build() async {
    return ChatScreenState();
  }

  void addDraft(String text) {
    state = AsyncValue.data(
      state.valueOrNull!.copyWith(
        drafts: [
          ...state.valueOrNull?.drafts ?? [],
          text,
        ],
      ),
    );
  }

  Future<void> addMainMessage(
      {required String text, required bool isBookmark}) async {
    await ref
        .read(memoStoreProvider.notifier)
        .addMemo(content: text, isBookmark: isBookmark);
  }

  Future<void> addDraftMessage({
    required String text,
    required int index,
  }) async {
    await ref
        .read(memoStoreProvider.notifier)
        .addMemo(content: text, isBookmark: false);
    final drafts = <String>[...state.valueOrNull?.drafts ?? []];
    drafts.removeAt(index);
    state = AsyncValue.data(
      state.valueOrNull!.copyWith(
        drafts: drafts,
      ),
    );
  }
}
