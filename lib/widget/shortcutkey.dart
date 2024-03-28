import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// アプリ内のショートカットキーを定義するクラス
///
/// Flutterの[ShortcutActivator]に依存するのでwidgetディレクトリに配置
enum ShortcutActivatorType {
  /// 新しいTodoを追加する
  newTodo(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyN),
    label: 'Add new Todo...',
  ),

  /// ウィンドウの固定を切り替える
  pinWindow(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyP),
    label: 'Pin window',
  ),

  /// Todoの状態を切り替える
  toggleDone(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.enter),
    label: 'Toggle done',
  ),

  /// ウィンドウを閉じる
  closeWindow(
    shortcutActivator: SingleActivator(LogicalKeyboardKey.escape),
    label: 'Close window',
  ),

  /// ウィンドウを表示・非表示を切り替える
  toggleWindow(
    shortcutActivator: SingleActivator(
      LogicalKeyboardKey.comma,
      shift: true,
      meta: true,
    ),
    label: 'Toggle window',
  ),
  ;

  const ShortcutActivatorType({
    required this.shortcutActivator,
    required this.label,
  });

  final SingleActivator shortcutActivator;

  final String label;

  /// [label]と[shortcutActivator]を表示する
  String get longLabel => '$label ($shortcutLabel)';

  /// ショートカットキーのラベルを取得する
  String get shortcutLabel {
    List<String> fullLabels = [];
    if (shortcutActivator.alt) {
      fullLabels.add(LogicalKeyboardKey.alt.keyLabel);
    }
    if (shortcutActivator.control) {
      fullLabels.add('⌃');
    }
    if (shortcutActivator.meta) {
      fullLabels.add('⌘');
    }
    if (shortcutActivator.shift) {
      fullLabels.add('⇧');
    }
    fullLabels.add(shortcutActivator.trigger.keyLabel);

    return fullLabels.join(' ');
  }
}
