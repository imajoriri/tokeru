import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widget/painting/border.dart';
import 'package:tokeru_widgets/widgets.dart';

/// チャットを送信するためのButton。
class SubmitButton extends HookWidget {
  final void Function()? onPressed;

  const SubmitButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final shape = AppSmoothRectangleBorder();
    return AppButton(
      onPressed: onPressed,
      style: AppButtonStyle(
        contentColor: context.appColors.onPrimary,
        backgroundColor: context.appColors.primary,
        shape: shape,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.appSpacing.smallX,
          horizontal: context.appSpacing.small,
        ),
        child: IconTheme.merge(
          child: const Icon(Icons.send),
          data: IconThemeData(
            size: 16,
            color: context.appColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
