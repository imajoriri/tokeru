import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedReorderableList<E extends Object> extends HookWidget {
  const AnimatedReorderableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onReorder,
    required this.isSameItem,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<E> items;

  final Widget Function(BuildContext, int) itemBuilder;

  final Function(int, int) onReorder;

  final bool Function(E, E) isSameItem;

  final EdgeInsetsGeometry padding;

  final bool shrinkWrap;

  final ScrollPhysics? physics;

  /// アイテムが削除されるアニメーションのduration
  static const removeDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return AnimatedReorderableListView<E>(
      items: items,
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      longPressDraggable: false,
      physics: physics,
      itemBuilder: itemBuilder,
      padding: padding,
      insertDuration: const Duration(milliseconds: 0),
      removeDuration: removeDuration,
      removeItemBuilder: (child, animation) {
        final ease = animation.drive(
          CurveTween(
            curve: const Interval(
              0,
              // この値を調整して削除のdelayを調整できる
              0.7,
              curve: Curves.easeInExpo,
            ),
          ),
        );
        return SizeTransition(
          sizeFactor: ease,
          child: FadeTransition(
            opacity: ease,
            child: child,
          ),
        );
      },
      onReorder: onReorder,
      isSameItem: isSameItem,
    );
  }
}
