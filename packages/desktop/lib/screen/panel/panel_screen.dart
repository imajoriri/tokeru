import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/controller/panel_screen/panel_screen_controller.dart';
import 'package:tokeru_desktop/utils/panel_method_channel.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/todos/todos.dart';
import 'package:tokeru_model/model/analytics_event/analytics_event_name.dart';
import 'package:tokeru_widgets/widgets.dart';

final GlobalKey _childKey = GlobalKey();

class PanelScreen extends HookConsumerWidget {
  const PanelScreen({
    super.key,
  });

  Future<void> _send(
    TextEditingController textEditingConroller,
    WidgetRef ref,
  ) async {
    ref.read(panelScreenControllerProvider.notifier).send(
          message: textEditingConroller.text,
        );
    textEditingConroller.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();

    // ウィンドウをロックしているかどうか。
    final isLocked = useState(false);

    // ビルド後にrequestFocusしないとエラーになるため、
    // addPostFrameCallbackを使用する。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelMethodChannel.addListner((type) async {
        switch (type) {
          case OsHandlerType.windowActive:
            focusNode.requestFocus();
            break;
          case OsHandlerType.windowInactive:
            // ロックしている場合はウィンドウを閉じない。
            if (!isLocked.value) {
              panelMethodChannel.closeWindow();
            } else {
              // インアクティブの状態で、フォーカスがあると入力できると間違えてしまうので、
              // フォーカスを外す。
              FocusManager.instance.primaryFocus?.unfocus();
            }
            break;
          default:
            break;
        }
      });
    });

    final textEditingConroller = useTextEditingController();
    final canSubmit = useState(textEditingConroller.text.isNotEmpty);

    // Widget全体をリサイズする。
    resize() {
      // リビルド後にサイズを取得しないと改行後のサイズが取得できない
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox renderBox =
            _childKey.currentContext!.findRenderObject() as RenderBox;
        final size = renderBox.size;
        panelMethodChannel.resizePanel(height: size.height.toInt());
      });
    }

    textEditingConroller.addListener(() {
      canSubmit.value = textEditingConroller.text.isNotEmpty;
      resize();
    });

    // todoが更新されたらリサイズする。
    ref.listen(todosProvider, (pre, next) {
      resize();
    });

    // ウィンドウのリサイズが完了するまでにエラーが発生しないように、
    // スクロールできるようにする。
    return Scaffold(
      backgroundColor: context.appColors.surface,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          key: _childKey,
          padding: const EdgeInsets.all(8.0),
          child: FocusableActionDetector(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.enter, meta: true):
                  ActivateIntent(),
              SingleActivator(LogicalKeyboardKey.escape): _CloseWindowIntent(),
            },
            actions: {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (intent) => _send(textEditingConroller, ref),
              ),
              _CloseWindowIntent: CallbackAction<_CloseWindowIntent>(
                onInvoke: (intent) => panelMethodChannel.closeWindow(),
              ),
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 閉じるボタン。
                    AppIconButton.small(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        panelMethodChannel.closeWindow();
                      },
                      tooltip: '',
                    ),
                    const Spacer(),
                    // ロックボタン。
                    AppIconButton.small(
                      icon: Icon(
                        isLocked.value
                            ? Icons.lock_rounded
                            : Icons.lock_open_rounded,
                      ),
                      onPressed: () {
                        isLocked.value = !isLocked.value;
                      },
                      tooltip: '',
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // todo。
                const _Todo(),

                SizedBox(height: context.appSpacing.smallX),

                // Chat text field
                ChatTextField(
                  focusNode: focusNode,
                  textEditingController: textEditingConroller,
                  onSubmit: (value) {
                    _send(textEditingConroller, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Todo extends HookConsumerWidget {
  const _Todo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider).valueOrNull;
    if (todos == null || todos.isEmpty) {
      return const SizedBox();
    }
    final firstTodo = todos.first;

    final textEditingController =
        useTextEditingController(text: firstTodo.title);

    useEffect(
      () {
        textEditingController.text = firstTodo.title;
        return null;
      },
      [firstTodo.title],
    );

    return TodoListItem(
      // Todoが変わった時にtitleも更新されてほしいので、keyとtitleを設定する。
      key: ValueKey(firstTodo.id + firstTodo.title),
      isDone: firstTodo.isDone,
      textEditingController: textEditingController,
      onToggleDone: (value) {
        ref.read(todosProvider.notifier).toggleTodoDone(todoId: firstTodo.id);
        FirebaseAnalytics.instance.logEvent(
          name: AnalyticsEventName.toggleTodoDone.name,
        );
      },
    );
  }
}

class _CloseWindowIntent extends Intent {
  const _CloseWindowIntent();
}
