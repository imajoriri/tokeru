enum AnalyticsEventName {
  /// Todoを追加した時のイベント。
  addTodo('add_todo'),

  /// Todoを完了にした時のイベント。
  toggleTodoDone('toggle_todo_done'),

  tapShortcutKey('tap_shortcut_key'),

  /// チャットを追加した時のイベント。
  addChat('add_chat'),
  ;

  final String name;

  const AnalyticsEventName(this.name);
}
