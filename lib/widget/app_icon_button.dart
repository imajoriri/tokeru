import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.size,
    this.padding,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final double? size;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size ?? 24,
      ),
      padding: padding ?? const EdgeInsets.all(0),
    );
  }
}
