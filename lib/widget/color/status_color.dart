import 'dart:ui';

/// ホバー時のカラーを返すメソッド。
Color getHoverColor(Color onContainer) {
  return onContainer.withOpacity(0.08);
}
