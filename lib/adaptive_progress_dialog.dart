library adaptive_progress_dialog;

import 'dart:io';

import 'package:adaptive_progress_dialog/adaptive_progress_dialog_result.dart';
import 'package:adaptive_progress_dialog/dialog/cupertino_dialog.dart';
import 'package:adaptive_progress_dialog/dialog/material_dialog.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressDialogStyle {
  AdaptiveProgressDialogStyle({
    this.titleTextStyle,
    this.contentTextStyle,
    this.confirmButtonTextStyle,
    this.cancelButtonTextStyle,
  });

  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? confirmButtonTextStyle;
  final TextStyle? cancelButtonTextStyle;
}

Future<AdaptiveProgressDialogResult<T>?> showProgressIndicatorDialog<T>(
  BuildContext context, {
  required String title,
  required String content,
  String? actionButtonLabel, // Ok by default
  String? cancelButtonLabel, // Cancel by default
  AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle,
  Future<T?> Function()? confirmButtonCallback,
  Future<void> Function()? cancelButtonCallback,
}) async {
  return await showDialog<AdaptiveProgressDialogResult<T>>(
    context: context,
    builder: (context) => AdaptiveProgressDialog(
      title: title,
      content: content,
      actionButtonLabel: actionButtonLabel,
      confirmButtonCallback: confirmButtonCallback,
      cancelButtonCallback: cancelButtonCallback,
    ),
  );
}

class AdaptiveProgressDialog<T> extends StatelessWidget {
  const AdaptiveProgressDialog({
    super.key,
    this.title,
    this.content,
    this.actionButtonLabel,
    this.confirmButtonCallback,
    this.cancelButtonCallback,
  });

  final String? title;
  final String? content;
  final String? actionButtonLabel;
  final Future<T?> Function()? confirmButtonCallback;
  final Future<void> Function()? cancelButtonCallback;

  @override
  Widget build(BuildContext context) {
    bool isProgressVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return _shouldBuildCupertino
            ? CupertinoDialog(
                title: title,
                content: content,
                actionButtonLabel: actionButtonLabel,
                actionButtonCallback: confirmButtonCallback,
                onCancelPressed: () => _onCancelPressed(context),
                isProgressVisible: isProgressVisible,
                onActionButtonPressed: () async {
                  setState(() => isProgressVisible = true);
                  await _onActionButtonPressed(context);
                },
              )
            : MaterialDialog(
                title: title,
                content: content,
                actionButtonLabel: actionButtonLabel,
                actionButtonCallback: confirmButtonCallback,
                onCancelPressed: () async => _onCancelPressed(context),
                isProgressVisible: isProgressVisible,
                onActionButtonPressed: () async {
                  setState(() => isProgressVisible = true);
                  await _onActionButtonPressed(context);
                },
              );
      },
    );
  }

  bool get _shouldBuildCupertino => Platform.isIOS || Platform.isMacOS;

  Future<void> _onCancelPressed(BuildContext context) async {
    final navigator = Navigator.of(context);

    await cancelButtonCallback?.call();

    navigator.pop(AdaptiveProgressDialogResult.canceled());
  }

  Future<void> _onActionButtonPressed(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final data = await confirmButtonCallback?.call();
      navigator.pop(AdaptiveProgressDialogResult.success(data));
    } catch (_) {
      navigator.pop(
        AdaptiveProgressDialogResult.error(),
      );
    }
  }
}
