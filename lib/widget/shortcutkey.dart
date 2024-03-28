import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// アプリ内のショートカットキーを定義するクラス
///
/// Flutterの[ShortcutActivator]に依存するのでwidgetディレクトリに配置
enum ShortcutActivatorType {
  /// 新しいTodoを追加する
  newTodo(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyN),
  ),

  /// ウィンドウの固定を切り替える
  pinWindow(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.keyP),
  ),

  /// Todoの状態を切り替える
  toggleDone(
    shortcutActivator: SingleActivator(meta: true, LogicalKeyboardKey.enter),
  ),

  /// ウィンドウを閉じる
  closeWindow(
    shortcutActivator: SingleActivator(LogicalKeyboardKey.escape),
  ),

  /// ウィンドウを表示・非表示を切り替える
  toggleWindow(
    shortcutActivator: SingleActivator(
      LogicalKeyboardKey.comma,
      shift: true,
      meta: true,
    ),
  ),
  ;

  const ShortcutActivatorType({required this.shortcutActivator});

  final SingleActivator shortcutActivator;

  /// ショートカットキーのラベルを取得する
  String get shortcutLabel {
    return shortcutActivator.toString().replaceAll("keys: ", "");
  }
}
