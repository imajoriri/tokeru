import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widgets.dart';

/// テキストボタン。
class AppTextButton extends HookWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      containerColor: context.appColors.onSurface,
      backgroundColor: context.appColors.surface,
      child: Padding(
        padding: EdgeInsets.all(context.appSpacing.small),
        child: DefaultTextStyle(
          style: context.appTextTheme.labelLarge,
          child: text,
        ),
      ),
    );
  }
}
