import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_flutter/systems/keyboard_key_extension.dart';

/// アプリ内のショートカットキーを定義するクラス
///
/// Flutterの[ShortcutActivator]に依存するのでwidgetディレクトリに配置
enum ShortcutActivatorType {
  /// 新しいTodoを追加する
  newTodo(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyN),
    label: 'Add new Todo...',
  ),

  /// 新しいTodoを現在のフォーカスの1つ下に追加する
  newTodoBelow(
    shortcutActivator: SingleActivator(
      LogicalKeyboardKey.enter,
    ),
    label: 'Add new Todo below...',
  ),

  /// Todoを削除する
  deleteTodo(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyD),
    label: 'Delete Todo',
  ),

  /// Todoの状態を切り替える
  toggleDone(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyK),
    label: 'Toggle done',
  ),

  /// Todoをひとつ上に移動する
  moveUp(
    shortcutActivator: SingleActivator(
      meta: true,
      LogicalKeyboardKey.arrowUp,
    ),
    label: 'Move up',
  ),

  /// Todoをひとつ下に移動する
  moveDown(
    shortcutActivator: SingleActivator(
      meta: true,
      LogicalKeyboardKey.arrowDown,
    ),
    label: 'Move down',
  ),

  /// Focusを上に移動する
  focusUp(
    shortcutActivator: SingleActivator(LogicalKeyboardKey.arrowUp),
    label: 'Focus up',
  ),

  /// Focusを下に移動する
  focusDown(
    shortcutActivator: SingleActivator(LogicalKeyboardKey.arrowDown),
    label: 'Focus down',
  ),

  /// フォーカスをTodoとChatの間で切り替える
  toggleFocus(
    shortcutActivator: SingleActivator(
      LogicalKeyboardKey.tab,
    ),
    label: 'Toggle focus',
  ),

  // ----ウィンドウ系----

  /// Quit the app
  quit(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyQ),
    label: 'Quit',
  ),

  /// データをリフレッシュする
  reload(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyR),
    label: 'Reload window',
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
      fullLabels.add(LogicalKeyboardKey.alt.shortcutLabel);
    }
    if (shortcutActivator.control) {
      fullLabels.add(LogicalKeyboardKey.alt.shortcutLabel);
    }
    if (shortcutActivator.meta) {
      fullLabels.add(LogicalKeyboardKey.meta.shortcutLabel);
    }
    if (shortcutActivator.shift) {
      fullLabels.add(LogicalKeyboardKey.alt.shortcutLabel);
    }
    fullLabels.add(shortcutActivator.trigger.keyLabel);

    return fullLabels.join(' ');
  }
}
