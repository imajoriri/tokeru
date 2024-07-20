import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/button/button.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// チャットを送信するためのButton。
class SubmitButton extends HookWidget {
  final void Function()? onPressed;

  const SubmitButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      containerColor: context.appColors.onPrimary,
      backgroundColor: context.appColors.primary,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.appSpacing.smallX,
          horizontal: context.appSpacing.small,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
