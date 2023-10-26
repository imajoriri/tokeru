import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';

class SidebarScreen extends HookConsumerWidget {
  const SidebarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final state = ref.watch(sidebarScreenControllerProvider);

    useEffect(() {
      textController.text = state.memo?.content ?? '';
      return null;
    }, [state.memo]);

    return Scaffold(
      body: TextField(
        controller: textController,
        maxLines: null,
        expands: true,
      ),
    );
  }
}
