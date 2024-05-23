part of 'todo_screen.dart';

class _TodayDoneSection extends HookConsumerWidget {
  const _TodayDoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todayDoneTodoControllerProvider).valueOrNull ?? [];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Today Done ${todos.length}',
        style: context.appTextTheme.titleSmall,
      ),
    );
  }
}
