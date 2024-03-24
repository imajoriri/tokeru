import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/window_size_mode/window_size_mode_controller.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/screen/text_field_screen/screen.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/controller/url/url_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      observers: [_AppObserver()],
      child: AppMaterialApp(
        home: _PlatformMenuBar(),
      ),
    ),
  );
}

/// [PlatformMenuBar]の中でRefを使うためにラップしたWidgetクラス
class _PlatformMenuBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: "",
          menus: [
            const PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'About Tokeru(WIP)',
                ),
              ],
            ),
            const PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Settings...(WIP)',
                ),
                PlatformMenuItem(
                  label: 'Share Tokeru(WIP)',
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Show or Hide Tokeru',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.comma,
                    shift: true,
                    meta: true,
                  ),
                  onSelected: () {
                    channel.invokeMethod(
                      AppMethodChannel.openOrClosePanel.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // todo
        PlatformMenu(
          label: "Todo",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'New Todo...',
                  onSelected: () async {
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toLarge();
                    await ref.read(todoControllerProvider.notifier).add(0);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref
                          .read(todoFocusControllerProvider.notifier)
                          .requestFocus(0);
                    });

                    await FirebaseAnalytics.instance.logEvent(
                      name: AnalyticsEventName.addTodo.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // window
        PlatformMenu(
          label: "Window",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Large Window',
                  onSelected: () async {
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toLarge();
                  },
                ),
                PlatformMenuItem(
                  label: 'Minimize Window',
                  onSelected: () async {
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toSmall();
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: '← Move Window to the Left',
                  onSelected: () async {
                    channel.invokeMethod(
                      AppMethodChannel.windowToLeft.name,
                    );
                  },
                ),
                PlatformMenuItem(
                  label: 'Move Window to the Right →',
                  onSelected: () async {
                    channel.invokeMethod(
                      AppMethodChannel.windowToRight.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // contact developer
        PlatformMenu(
          label: "You are welcome to contact me!👋",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Thank you for using Tokeru!😊',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
                PlatformMenuItem(
                  label: 'I would like to hear your feedback!',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: '📩 Follow on X(Twitter)',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '💡 Got an idea for a feature',
                  onSelected: () async {
                    await UrlController.featureRequest.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '📝 Found a bug',
                  onSelected: () async {
                    await UrlController.bugReport.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '🧑‍💻 Tokeru repository is public',
                  onSelected: () async {
                    await UrlController.tokeruRepository.launch();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      child: TextFieldScreen(),
    );
  }
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.seed,
              outline: AppColor.outline,
              outlineVariant: AppColor.outlineVariant,
              shadow: AppColor.shadow,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
}
