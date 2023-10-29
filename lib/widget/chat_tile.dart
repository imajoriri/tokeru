import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';

class ChatTile extends HookConsumerWidget {
  final Memo memo;
  final Function(Memo) onTapBookmark;
  final Function() onTap;
  final int? maxLines;

  const ChatTile({
    Key? key,
    required this.memo,
    required this.onTapBookmark,
    required this.onTap,
    this.maxLines,
  }) : super(key: key);

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
              : Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                // TODO: 正しい色に変える
                backgroundColor: Theme.of(context).hoverColor,
                child: IconButton(
                  onPressed: () {
                    onTapBookmark.call(memo);
                  },
                  icon: Icon(
                    memo.isBookmark ? Icons.bookmark : Icons.bookmark_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  memo.content,
                  maxLines: maxLines,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
