enum AnalyticsEventName {
  addTodo('add_todo'),
  toggleTodoDone('toggle_todo_done'),
  tapShortcutKey('tap_shortcut_key'),
  ;

  final String name;

  const AnalyticsEventName(this.name);
}
