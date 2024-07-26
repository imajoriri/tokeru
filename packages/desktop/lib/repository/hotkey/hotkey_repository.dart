import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/systems.dart';

part 'hotkey_repository.g.dart';

@Riverpod(keepAlive: true)
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
