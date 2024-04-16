import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/hot_key/hot_key_controller.dart';
import 'package:quick_flutter/controller/screen_type/screen_type_controller.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/systems/keyboard_key_extension.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hotkey',
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
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
                    Text(modifier.shortcutLabel),
                  ],
                ),
              ),
            ],
          ],
        ),
        if (ref.watch(hotKeyControllerProvider).hasError)
          Text(
            ref.watch(hotKeyControllerProvider).error.toString(),
            style: context.textTheme.labelMedium!.copyWith(
              color: context.colorScheme.error,
            ),
          ),
      ],
    );
  }
}
