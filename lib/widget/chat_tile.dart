import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_span.dart';

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

    final bookmarkColor = memo.isBookmark
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: () {
        onTapBookmark.call(memo);
      },
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
              SizedBox(
                width: 28,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                        // bookmark
                        if (onHover.value || memo.isBookmark) ...[
                          const SizedBox(width: 8),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                onTapBookmark.call(memo);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    size: 12,
                                    color: bookmarkColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Text("bookmark",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: bookmarkColor)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    RichText(
                        maxLines: maxLines,
                        text: MarkdownTextSpan(
                            text: memo.content,
                            style: Theme.of(context).textTheme.bodyMedium)),
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
