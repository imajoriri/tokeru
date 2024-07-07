import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:logger/logger.dart';
import 'package:quick_flutter/controller/hot_key/hot_key_controller.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/screen/main/main_screen.dart';
import 'package:quick_flutter/screen/panel/panel_screen.dart';
import 'package:quick_flutter/utils/method_channel.dart';
import 'package:quick_flutter/widget/app_platform_menu_bar.dart';
import 'package:quick_flutter/widget/callback_shortcut.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

@pragma('vm:entry-point')
void panel() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      observers: [_AppObserver()],
      child: AppMaterialApp(
        home: const Material(
          child: PanelScreen(),
        ),
      ),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await hotKeyManager.unregisterAll();

  runApp(
    ProviderScope(
      observers: [_AppObserver()],
      child: AppMaterialApp(
        home: AppCallbackShortcuts(
          child: AppPlatformMenuBar(
            child: Consumer(
              builder: (context, ref, child) {
                // 画面表示時にホットキーを登録するためにProviderを参照する。
                // リビルドされたいわけではないのでreadを使う。
                ref.read(hotKeyControllerProvider);

                mainMethodChannel.addListnerActive((_) async {
                  if (ref.read(refreshControllerProvider.notifier).isPast()) {
                    ref.invalidate(refreshControllerProvider);
                  }
                });

                return Material(
                  color: context.appColors.backgroundDefault,
                  child: const MainScreen(),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class _AppObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      final logger = Logger();
      logger.e(
        newValue.error.toString(),
        error: newValue.error,
        stackTrace: newValue.stackTrace,
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final logger = Logger();
    logger.e(
      error,
      error: error,
      stackTrace: stackTrace,
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
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
}
