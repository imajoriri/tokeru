import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_span.dart';

class ChatTile extends HookConsumerWidget {
  final Memo memo;
  final Function() onTap;
  final int? maxLines;
  final Function(String value)? onChanged;
  final Color? color;

  const ChatTile({
    Key? key,
    required this.memo,
    required this.onTap,
    this.color,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);

    return GestureDetector(
      onTap: onTap,
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
              : color ?? Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: 28,
              //   child: CircleAvatar(
              //     backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              //     child: Icon(
              //       Icons.person,
              //       size: 20,
              //       color: Theme.of(context).colorScheme.onSurfaceVariant,
              //     ),
              //   ),
              // ),
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
                      ],
                    ),
                    SelectableText.rich(
                      maxLines: maxLines,
                      MarkdownTextSpan(
                        text: memo.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {
                          onChanged?.call(value);
                        },
                      ),
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
