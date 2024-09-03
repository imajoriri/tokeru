import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tokeru_desktop/controller/hot_key/hot_key_controller.dart';
import 'package:tokeru_model/firebase_options.dart';
import 'package:tokeru_desktop/screen/main/main_screen.dart';
import 'package:tokeru_desktop/screen/panel/panel_screen.dart';
import 'package:tokeru_desktop/widget/app_platform_menu_bar.dart';
import 'package:tokeru_desktop/widget/callback_shortcut.dart';
import 'package:tokeru_widgets/widgets.dart';

@pragma('vm:entry-point')
void panel() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
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
  await initializeFirebase();

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

                return Material(
                  color: context.appColors.surface,
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
