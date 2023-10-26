import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';

class ChatTile extends HookConsumerWidget {
  final Memo memo;
  final Function(Memo) onTapBookmark;

  const ChatTile({
    Key? key,
    required this.memo,
    required this.onTapBookmark,
  }) : super(key: key);

  // 改行がある場合は1行目を3点リーダー付きで返す
  String get text => '${memo.content.split('\n').first}...';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);
    return MouseRegion(
      onExit: (pointer) {
        onHover.value = false;
      },
      onEnter: (event) {
        onHover.value = true;
      },
      child: Container(
        color: onHover.value ? Colors.grey.shade200 : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                onTapBookmark.call(memo);
              },
              icon: Icon(
                Icons.bookmark,
                color: memo.isBookmark ? Colors.deepPurple : Colors.grey,
              ),
            ),
            Text(
              memo.isBookmark ? text : memo.content,
              // maxLines: memo.isBookmark ? 1 : null,
              // overflow: memo.isBookmark ? TextOverflow.ellipsis : null,
            ),
          ],
        ),
      ),
    );
  }
}
