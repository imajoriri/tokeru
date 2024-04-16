import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/repository/hotkey/hotkey_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hot_key_controller.g.dart';
part 'hot_key_controller.freezed.dart';

@freezed
class HotKeyState with _$HotKeyState {
  const factory HotKeyState({
    required LogicalKeyboardKey key,
    required List<LogicalKeyboardKey> modifiers,
  }) = _HotKeyState;
}

/// アプリを起動するためのホットキーを登録するController
@riverpod
class HotKeyController extends _$HotKeyController {
  @override
  Future<HotKeyState> build() async {
    final (:keyId, :modifiers) =
        await ref.watch(hotkeyRepositoryProvider).fetchHotkey();
    final hotKey = HotKey(
      key: keyId != null ? LogicalKeyboardKey(keyId) : LogicalKeyboardKey.comma,
      modifiers: modifiers
              ?.map(
                (e) =>
                    _convertLogicalKeyboardKeyToModifier(LogicalKeyboardKey(e)),
              )
              .toList() ??
          [HotKeyModifier.meta, HotKeyModifier.shift],
    );

    hotKeyManager.register(
      hotKey,
      keyDownHandler: _keyDownHandler,
    );
    return HotKeyState(
      key: hotKey.logicalKey,
      modifiers: hotKey.modifiers
              ?.map(_convertModifierToLogicalKeyboardKey)
              .toList() ??
          [],
    );
  }

  /// Hotkeyのキーのmodifierを切り替える
  ///
  /// [modifier]が既に登録されている場合は削除し、登録されていない場合は追加する。
  /// modifierが0になるようであればAsyncErrorにする。
  Future<void> toggleModifier(LogicalKeyboardKey modifier) async {
    final modifiers = [
      ...state.valueOrNull?.modifiers ?? <LogicalKeyboardKey>[],
    ];
    if (modifiers.contains(modifier)) {
      modifiers.remove(modifier);
    } else {
      modifiers.add(modifier);
    }
    // modifierが0になるようであればAsyncErrorにする
    if (modifiers.isEmpty) {
      state =
          AsyncError('modifier key must be at least one', StackTrace.current);
      return;
    }
    final key = state.valueOrNull!.key;
    await _updateKey(key, modifiers);
  }

  /// Hotkeyのキーを設定する
  Future<void> setKey(LogicalKeyboardKey key) async {
    final modifiers = state.valueOrNull?.modifiers ?? <LogicalKeyboardKey>[];
    await _updateKey(key, modifiers);
  }

  Future<void> _keyDownHandler(HotKey hotKey) async {
    final channel = ref.read(methodChannelProvider);
    channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
  }

  /// Hotkeyを解除・更新する
  Future<void> _updateKey(
    LogicalKeyboardKey key,
    List<LogicalKeyboardKey> modifiers,
  ) async {
    final hotKey = HotKey(
      key: key,
      modifiers: modifiers.map(_convertLogicalKeyboardKeyToModifier).toList(),
    );
    await hotKeyManager.unregisterAll();
    hotKeyManager.register(
      hotKey,
      keyDownHandler: _keyDownHandler,
    );
    ref.read(hotkeyRepositoryProvider).updateHotkey(
          key.keyId,
          modifiers.map((e) => e.keyId).toList(),
        );
    state = AsyncData(HotKeyState(key: key, modifiers: modifiers));
  }
}

/// [HotKeyModifier]を[LogicalKeyboardKey]に変換する関数
LogicalKeyboardKey _convertModifierToLogicalKeyboardKey(
  HotKeyModifier modifier,
) {
  switch (modifier) {
    case HotKeyModifier.alt:
      return LogicalKeyboardKey.alt;
    case HotKeyModifier.capsLock:
      return LogicalKeyboardKey.capsLock;
    case HotKeyModifier.control:
      return LogicalKeyboardKey.control;
    case HotKeyModifier.fn:
      return LogicalKeyboardKey.fn;
    case HotKeyModifier.meta:
      return LogicalKeyboardKey.meta;
    case HotKeyModifier.shift:
      return LogicalKeyboardKey.shift;
  }
}

/// [LogicalKeyboardKey]を[HotKeyModifier]に変換する関数
HotKeyModifier _convertLogicalKeyboardKeyToModifier(
  LogicalKeyboardKey key,
) {
  switch (key) {
    case LogicalKeyboardKey.alt:
      return HotKeyModifier.alt;
    case LogicalKeyboardKey.capsLock:
      return HotKeyModifier.capsLock;
    case LogicalKeyboardKey.control:
      return HotKeyModifier.control;
    case LogicalKeyboardKey.fn:
      return HotKeyModifier.fn;
    case LogicalKeyboardKey.meta:
      return HotKeyModifier.meta;
    case LogicalKeyboardKey.shift:
      return HotKeyModifier.shift;
    default:
      throw ArgumentError('Invalid LogicalKeyboardKey: $key');
  }
}
