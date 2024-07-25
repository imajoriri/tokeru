import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/controller/hot_key/hot_key_controller.dart';
import 'package:tokeru_desktop/controller/screen_type/screen_type_controller.dart';
import 'package:tokeru_desktop/systems/context_extension.dart';
import 'package:tokeru_desktop/systems/keyboard_key_extension.dart';
import 'package:tokeru_desktop/widget/theme/app_theme.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Hotkey
                    _HotkeyItem(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(screenTypeControllerProvider.notifier).screenType =
                        ScreenType.todo;
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HotkeyItem extends HookConsumerWidget {
  const _HotkeyItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModifiers =
        ref.watch(hotKeyControllerProvider).valueOrNull?.modifiers ?? [];
    final selectedKey = ref.watch(hotKeyControllerProvider).valueOrNull?.key;

    final modifiers = [
      LogicalKeyboardKey.meta,
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.shift,
    ];

    final keys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyB,
      LogicalKeyboardKey.keyC,
      LogicalKeyboardKey.keyD,
      LogicalKeyboardKey.keyE,
      LogicalKeyboardKey.keyF,
      LogicalKeyboardKey.keyG,
      LogicalKeyboardKey.keyH,
      LogicalKeyboardKey.keyI,
      LogicalKeyboardKey.keyJ,
      LogicalKeyboardKey.keyK,
      LogicalKeyboardKey.keyL,
      LogicalKeyboardKey.keyM,
      LogicalKeyboardKey.keyN,
      LogicalKeyboardKey.keyO,
      LogicalKeyboardKey.keyP,
      LogicalKeyboardKey.keyQ,
      LogicalKeyboardKey.keyR,
      LogicalKeyboardKey.keyS,
      LogicalKeyboardKey.keyT,
      LogicalKeyboardKey.keyU,
      LogicalKeyboardKey.keyV,
      LogicalKeyboardKey.keyW,
      LogicalKeyboardKey.keyX,
      LogicalKeyboardKey.keyY,
      LogicalKeyboardKey.keyZ,
      LogicalKeyboardKey.comma,
      LogicalKeyboardKey.period,
      LogicalKeyboardKey.space,
      LogicalKeyboardKey.enter,
      LogicalKeyboardKey.escape,
      LogicalKeyboardKey.backspace,
      LogicalKeyboardKey.delete,
      LogicalKeyboardKey.arrowUp,
      LogicalKeyboardKey.arrowDown,
      LogicalKeyboardKey.arrowLeft,
      LogicalKeyboardKey.arrowRight,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hotkey',
          style: context.appTextTheme.labelMidium,
        ),
        Text(
          'Open or hide the panel with a hotkey.',
          style: context.appTextTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final modifier in modifiers) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: selectedModifiers.contains(modifier),
                      onChanged: (value) {
                        ref
                            .read(hotKeyControllerProvider.notifier)
                            .toggleModifier(modifier);
                      },
                    ),
                    Text(
                      modifier.shortcutLabel,
                      style: context.appTextTheme.labelMidium,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(width: 8),
            MenuAnchor(
              builder: (
                BuildContext context,
                MenuController controller,
                Widget? child,
              ) {
                return ElevatedButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedKey?.shortcutLabel ?? 'Key',
                        style: context.appTextTheme.labelMidium,
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                );
              },
              menuChildren: List<MenuItemButton>.generate(
                keys.length,
                (int index) => MenuItemButton(
                  onPressed: () {
                    ref
                        .read(hotKeyControllerProvider.notifier)
                        .setKey(keys[index]);
                  },
                  child: Text(
                    keys[index].shortcutLabel,
                    style: context.appTextTheme.labelMidium,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (ref.watch(hotKeyControllerProvider).hasError)
          Text(
            ref.watch(hotKeyControllerProvider).error.toString(),
            style: context.textTheme.labelMedium!.copyWith(
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
