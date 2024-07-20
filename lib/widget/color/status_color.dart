import 'dart:ui';

extension StatusColor on Color {
  /// ホバー時のカラーを返すメソッド。
  Color get hovered => withOpacity(0.08);

  /// フォーカス時のカラーを返すメソッド。
  Color get focused => withOpacity(0.10);

  /// プレス時のカラーを返すメソッド。
  Color get pressed => withOpacity(0.10);

  /// Disabledのカラーを返すメソッド。
  Color get disabled => withOpacity(0.38);
}
