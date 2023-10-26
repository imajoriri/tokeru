import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';

class ChatTile extends HookConsumerWidget {
  final Memo memo;
  final Function(Memo) onTapBookmark;
  final Function() onTap;

  const ChatTile({
    Key? key,
    required this.memo,
    required this.onTapBookmark,
    required this.onTap,
  }) : super(key: key);

  // 改行がある場合は1行目を3点リーダー付きで返す
  String get text => '${memo.content.split('\n').first}...';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: (pointer) {
          onHover.value = false;
        },
        onEnter: (event) {
          onHover.value = true;
        },
        child: Container(
          color: onHover.value
              ? Theme.of(context).hoverColor
              : Theme.of(context).colorScheme.background,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  onTapBookmark.call(memo);
                },
                icon: Icon(
                  memo.isBookmark ? Icons.bookmark : Icons.bookmark_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                memo.isBookmark ? text : memo.content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
