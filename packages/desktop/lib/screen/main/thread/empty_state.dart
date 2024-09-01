part of 'thread_view.dart';

/// スレッドが選択されていない場合のUI。
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          'No todo selected',
        ),
      ),
    );
  }
}
