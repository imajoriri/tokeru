import 'package:flutter/material.dart';

abstract class CustomAction<T extends Intent> extends Action {
  /// [invoke]メソッドの戻り値が[KeyEventResult]の場合はそのまま返すようoverrideしたメソッド
  ///
  /// [invoke]メソッドの戻り値が[KeyEventResult]以外の場合は、元の[Action.toKeyEventResult]メソッドを呼び出す
  @override
  KeyEventResult toKeyEventResult(
    Intent intent,
    covariant Object? invokeResult,
  ) {
    // invokeResultがKeyEventResultの場合はそのまま返す
    if (invokeResult is KeyEventResult) {
      return invokeResult;
    }

    return super.toKeyEventResult(intent, invokeResult);
  }
}
