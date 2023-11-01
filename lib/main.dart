import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/screen/memo/screen.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/screen/sidebar_screen/sidebar_screen.dart';
import 'package:quick_flutter/systems/color.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      home: Row(
        children: [
          const Flexible(child: MemoScreen()),
          if (ref.watch(sidebarScreenControllerProvider).isShow) ...[
            const Flexible(child: SidebarScreen()),
          ]
        ],
      ),
    );
  }
}
