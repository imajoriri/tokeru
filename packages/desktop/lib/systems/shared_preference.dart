import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceType {
  hotkey,
  hotkeyModifiers,
}

extension PreferenceTypeEx on PreferenceType {
  String get key => name;

  Future<String?> getString() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key)) {
      final pre = pref.get(key);
      if (pre != null) {
        return pre.toString();
      }
    }
    return null;
  }

  Future<bool> setString(String value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  Future<List<String>?> getStringList() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }

  Future<int?> getInt() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<bool> setInt(int value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setInt(key, value);
  }

  Future<bool> setIntList(List<int> value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setStringList(key, value.map((e) => e.toString()).toList());
  }

  Future<List<int>?> getIntList() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList(key);
    if (list != null) {
      return list.map((e) => int.parse(e)).toList();
    }
    return null;
  }

  Future<bool> setStringList(List<String> value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setStringList(key, value);
  }

  Future<void> delete() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}
