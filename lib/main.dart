import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/screen/memo/screen.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/screen/sidebar_screen/sidebar_screen.dart';
import 'package:quick_flutter/store/focus_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/widget/shortcut_intent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
void panel() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  /// メモの一覧を0時にリセット
  void updateMemos(WidgetRef ref) {
    DateTime now = DateTime.now();
    // 次の日の0時1分を計算
    DateTime initialDelay = DateTime(now.year, now.month, now.day + 1, 0, 1);
    Duration delay = initialDelay.difference(now);

    Future.delayed(delay).then((_) {
      ref.invalidate(memosProvider);
      updateMemos(ref);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      updateMemos(ref);
      return null;
    }, []);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.seed,
          outline: AppColor.outline,
          outlineVariant: AppColor.outlineVariant,
          shadow: AppColor.shadow,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
          ),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(
            LogicalKeyboardKey.meta,
            LogicalKeyboardKey.keyN,
          ): CommandNIntent(),
          LogicalKeySet(
            LogicalKeyboardKey.meta,
            LogicalKeyboardKey.enter,
          ): CommandEnterIntent(),
          LogicalKeySet(
            LogicalKeyboardKey.escape,
          ): EscIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            CommandNIntent: CallbackAction(
              onInvoke: (intent) {
                ref.watch(focusNodeProvider(FocusNodeType.chat)).requestFocus();
                return null;
              },
            ),
          },
          child: GestureDetector(
            onTap: () {
              ref.watch(focusNodeProvider(FocusNodeType.main)).requestFocus();
            },
            child: Focus(
              autofocus: true,
              focusNode: ref.watch(focusNodeProvider(FocusNodeType.main)),
              child: Row(
                children: [
                  const Flexible(child: MemoScreen()),
                  if (ref.watch(sidebarScreenControllerProvider).isShow) ...[
                    const Flexible(child: SidebarScreen()),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
