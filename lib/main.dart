import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/screen/main_memo/screen.dart';
import 'package:quick_flutter/screen/memo/screen.dart';
import 'package:quick_flutter/screen/text_field_screen.dart/screen.dart';
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
      child: MyApp2(),
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
      child: NSPanel(),
    ),
  );
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AppMaterialApp(
        home: const MainMemoScreen(),
      ),
    );
  }
}

class NSPanel extends StatelessWidget {
  const NSPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AppMaterialApp(
        home: TextFieldScreen(),
      ),
    );
  }
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final List<LogicalKeyboardKey> pressedLogicalKeys = [];

  final shortcuts = <LogicalKeySet, Intent>{
    LogicalKeySet(
      LogicalKeyboardKey.metaLeft,
      LogicalKeyboardKey.keyN,
    ): FocusChatTextFieldIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.metaRight,
      LogicalKeyboardKey.keyN,
    ): FocusChatTextFieldIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.metaLeft,
      LogicalKeyboardKey.enter,
    ): CommandEnterIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.metaRight,
      LogicalKeyboardKey.enter,
    ): CommandEnterIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.escape,
    ): EscIntent(),
  };

  /// メモの一覧を0時にリセット
  void updateMemos(WidgetRef ref) {
    DateTime now = DateTime.now();
    // 次の日の0時1分を計算
    DateTime initialDelay = DateTime(now.year, now.month, now.day + 1, 0, 1);
    Duration delay = initialDelay.difference(now);

    Future.delayed(delay).then((_) {
      ref.invalidate(memoStoreProvider);
      updateMemos(ref);
    });
  }

  // void setMethodCallHandler() {
  //   const channel = MethodChannel("net.cbtdev.sample/method");
  //   channel.setMethodCallHandler((MethodCall call) async {
  //     switch (call.method) {
  //       case 'openPanel':
  //         pressedLogicalKeys.removeWhere((e) => true);

  //         // sidebarにフォーカスがなければchatにフォーカスを移す
  //         if (ref
  //             .watch(focusNodeProvider(FocusNodeType.sidebarChat))
  //             .hasFocus) {
  //           break;
  //         }
  //         final primaryContext =
  //             WidgetsBinding.instance.focusManager.primaryFocus!.context!;
  //         final action = Actions.maybeFind<Intent>(
  //           WidgetsBinding.instance.focusManager.primaryFocus!.context!,
  //           intent: FocusChatTextFieldIntent(),
  //         );
  //         if (action != null) {
  //           Actions.of(primaryContext).invokeActionIfEnabled(
  //             action,
  //             FocusChatTextFieldIntent(),
  //             primaryContext,
  //           );
  //         }
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      updateMemos(ref);
      return null;
    }, []);

    return AppMaterialApp(
      home: Actions(
        actions: <Type, Action<Intent>>{
          FocusChatTextFieldIntent: CallbackAction(
            onInvoke: (intent) {
              return null;
            },
          ),
        },
        child: Focus(
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent) {
              pressedLogicalKeys.add(event.logicalKey);
            } else if (event is KeyUpEvent) {
              pressedLogicalKeys.remove(event.logicalKey);
            }
            // shortcutsの中から該当するものを探す
            for (final shortcut in shortcuts.entries) {
              if (shortcut.key.keys.every((key) {
                return pressedLogicalKeys.contains(key);
              })) {
                final primaryContext =
                    WidgetsBinding.instance.focusManager.primaryFocus!.context!;
                final action = Actions.maybeFind<Intent>(
                  WidgetsBinding.instance.focusManager.primaryFocus!.context!,
                  intent: shortcut.value,
                );
                if (action == null) {
                  return KeyEventResult.ignored;
                }
                final (bool enabled, Object? _) =
                    Actions.of(primaryContext).invokeActionIfEnabled(
                  action,
                  shortcut.value,
                  primaryContext,
                );
                if (enabled) {
                  return KeyEventResult.handled;
                }
              }
            }

            return KeyEventResult.ignored;
          },
          child: const Row(
            children: [
              Flexible(child: MemoScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

class AppMaterialApp extends MaterialApp {
  AppMaterialApp({
    Key? key,
    required Widget home,
  }) : super(
          key: key,
          home: home,
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
        );
}
