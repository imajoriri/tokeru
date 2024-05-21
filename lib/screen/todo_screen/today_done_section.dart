part of 'todo_screen.dart';

class _TodayDoneSection extends HookConsumerWidget {
  const _TodayDoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todayDoneTodoControllerProvider).valueOrNull ?? [];
    return Text('Today Done ${todos.length}');
  }
}
