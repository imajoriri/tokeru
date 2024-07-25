import 'package:flutter/services.dart';

extension LogicalKeyboardKeyEx on LogicalKeyboardKey {
  String get shortcutLabel {
    return switch (this) {
      LogicalKeyboardKey.control => '⌃',
      LogicalKeyboardKey.shift => '⇧',
      LogicalKeyboardKey.meta => '⌘',
      LogicalKeyboardKey.alt => '⌥',
      LogicalKeyboardKey.space => 'Space',
      _ => keyLabel,
    };
  }
}
