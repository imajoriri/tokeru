import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/widget/app_icon_button.dart';

class SidebarScreen extends HookConsumerWidget {
  const SidebarScreen({super.key});

  static const debounceDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final state = ref.watch(sidebarScreenControllerProvider);

    useEffect(() {
      textController.text = state.memo?.content ?? '';
      return null;
    }, [state.memo]);

    final debounce = useState<Timer?>(null);
    useEffect(
      () {
        textController.addListener(() {
          if (debounce.value?.isActive ?? false) {
            debounce.value?.cancel();
          }

          debounce.value = Timer(debounceDuration, () {
            ref
                .read(sidebarScreenControllerProvider.notifier)
                .update(content: textController.text);
          });
        });

        return () {
          debounce.value?.cancel();
        };
      },
      [textController],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(1, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppIconButton(
                      onPressed: () {
                        ref
                            .read(sidebarScreenControllerProvider.notifier)
                            .close();
                      },
                      icon: Icons.close),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
