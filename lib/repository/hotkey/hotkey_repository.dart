import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/systems/shared_preference.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hotkey_repository.g.dart';

@riverpod
HotkeyRepository hotkeyRepository(HotkeyRepositoryRef ref) =>
    HotkeyRepository(ref: ref);

class HotkeyRepository {
  HotkeyRepository({
    required this.ref,
  });
  final Ref ref;

  Future<({int? keyId, List<int>? modifiers})> fetchHotkey() async {
    final keyId = await PreferenceType.hotkey.getInt();
    final modifiers = await PreferenceType.hotkeyModifiers.getIntList();
    return (keyId: keyId, modifiers: modifiers);
  }

  Future<void> updateHotkey(int keyId, List<int> modifiers) async {
    await PreferenceType.hotkey.setInt(keyId);
    await PreferenceType.hotkeyModifiers.setIntList(modifiers);
  }
}
