import 'package:flutter/services.dart';

extension LogicalKeyboardKeyEx on LogicalKeyboardKey {
  String get shortcutLabel {
    return switch (this) {
      LogicalKeyboardKey.control => '⌃',
      LogicalKeyboardKey.shift => '⇧',
      LogicalKeyboardKey.meta => '⌘',
      LogicalKeyboardKey.alt => '⌥',
      _ => keyLabel,
    };
  }
}
