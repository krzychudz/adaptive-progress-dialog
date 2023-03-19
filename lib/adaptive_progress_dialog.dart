library adaptive_progress_dialog;

import 'dart:io';

import 'package:adaptive_progress_dialog/adaptive_progress_dialog_result.dart';
import 'package:adaptive_progress_dialog/dialog/cupertino_dialog.dart';
import 'package:adaptive_progress_dialog/dialog/material_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressDialogStyle {
  AdaptiveProgressDialogStyle({
    this.titleTextStyle,
    this.contentTextStyle,
    this.confirmButtonTextStyle,
    this.cancelButtonTextStyle,
    this.materialContentPadding,
    this.materialActionsPadding,
    this.materialActionsAlignment,
  });

  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? confirmButtonTextStyle;
  final TextStyle? cancelButtonTextStyle;
  final EdgeInsets? materialContentPadding;
  final EdgeInsets? materialActionsPadding;
  final MainAxisAlignment? materialActionsAlignment;
}

class AdaptiveProgressDialog<T> {
  AdaptiveProgressDialog({
    required this.title,
    required this.content,
    this.confirmationButtonLabel,
    this.cancelButtonLabel,
    this.adaptiveProgressDialogStyle,
    this.confirmButtonCallback,
    this.cancelButtonCallback,
  });

  final String title;
  final String content;
  final String? confirmationButtonLabel; // Ok by default
  final String? cancelButtonLabel; // Cancel by default
  final AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle;
  final Future<T?> Function()? confirmButtonCallback;
  final Future<void> Function()? cancelButtonCallback;

  Future<AdaptiveProgressDialogResult<T?>> show(BuildContext context) async {
    final result = await showDialog<AdaptiveProgressDialogResult<T?>>(
      context: context,
      builder: (context) => ProgressDialog(
        title: title,
        content: content,
        confirmationButtonLabel: confirmationButtonLabel,
        cancelButtonLabel: cancelButtonLabel,
        confirmButtonCallback: confirmButtonCallback,
        cancelButtonCallback: cancelButtonCallback,
        adaptiveProgressDialogStyle: adaptiveProgressDialogStyle,
      ),
    );

    if (result == null) return AdaptiveProgressDialogResult.closed();
    return result;
  }
}

class ProgressDialog<T> extends StatelessWidget {
  const ProgressDialog({
    super.key,
    this.title,
    this.content,
    this.confirmationButtonLabel,
    this.cancelButtonLabel,
    this.confirmButtonCallback,
    this.cancelButtonCallback,
    this.adaptiveProgressDialogStyle,
  });

  final String? title;
  final String? content;
  final String? confirmationButtonLabel;
  final String? cancelButtonLabel;
  final Future<T?> Function()? confirmButtonCallback;
  final Future<void> Function()? cancelButtonCallback;
  final AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle;

  @override
  Widget build(BuildContext context) {
    bool isActionInProgress = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return _shouldBuildCupertino
            ? CupertinoDialog(
                title: title,
                content: content,
                confirmationButtonLabel: confirmationButtonLabel,
                onCancelPressed: () => _onCancelPressed(context),
                isActionInProgress: isActionInProgress,
                onActionButtonPressed: () async {
                  setState(() => isActionInProgress = true);
                  await _onConfirmationButtonPressed(context);
                },
                adaptiveProgressDialogStyle: adaptiveProgressDialogStyle,
              )
            : MaterialDialog(
                title: title,
                content: content,
                confirmationButtonLabel: confirmationButtonLabel,
                cancelButtonLabel: cancelButtonLabel,
                onCancelPressed: () async => _onCancelPressed(context),
                isActionInProgress: isActionInProgress,
                onActionButtonPressed: () async {
                  setState(() => isActionInProgress = true);
                  await _onConfirmationButtonPressed(context);
                },
                adaptiveProgressDialogStyle: adaptiveProgressDialogStyle,
              );
      },
    );
  }

  bool get _shouldBuildCupertino =>
      kIsWeb ? false : Platform.isIOS || Platform.isMacOS;

  Future<void> _onCancelPressed(BuildContext context) async {
    final navigator = Navigator.of(context);

    await cancelButtonCallback?.call();
    navigator.pop(AdaptiveProgressDialogResult<T?>.canceled());
  }

  Future<void> _onConfirmationButtonPressed(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final data = await confirmButtonCallback?.call();
      navigator.pop(AdaptiveProgressDialogResult<T?>.success(data));
    } catch (_) {
      navigator.pop(
        AdaptiveProgressDialogResult<T?>.error(),
      );
    }
  }
}
