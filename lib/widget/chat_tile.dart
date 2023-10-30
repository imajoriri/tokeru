import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/systems/context_extension.dart';

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
      // onTap: onTap,
      child: MouseRegion(
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
            crossAxisAlignment: maxLines == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).hoverColor,
                child: IconButton(
                  onPressed: () {
                    onTapBookmark.call(memo);
                  },
                  iconSize: 20,
                  icon: Icon(
                    memo.isBookmark ? Icons.bookmark : Icons.bookmark_border,
                    // size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(context.dateFormat.format(memo.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
                        if (onHover.value) ...[
                          const SizedBox(width: 8),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                onTapBookmark.call(memo);
                              },
                              child: Text("bookmark",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                onTap.call();
                              },
                              child: Text("sidebar",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      memo.content,
                      maxLines: maxLines,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
