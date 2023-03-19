import 'dart:io';

import 'package:adaptive_progress_dialog/adaptive_progress_dialog_result.dart';
import 'package:adaptive_progress_dialog/adaptive_progress_dialog_style.dart';
import 'package:adaptive_progress_dialog/dialog/cupertino_dialog.dart';
import 'package:adaptive_progress_dialog/dialog/material_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///ProgressDialog widget that is used to create a
///progress dialog with an adaptive style depending on the platform.
///The class is generic and takes a type parameter T which is used to
///represent the data that can be returned from the [confirmButtonCallback] method.
///The ProgressDialog widget has several parameters:
///[title] A string representing the title of the dialog.
///[content] A string representing the content of the dialog.
///[confirmationButtonLabel] A string representing the label of the confirmation button.
///[cancelButtonLabel] A string representing the label of the cancel button.
///[confirmButtonCallback] A function that returns a Future<T?> and is called when the confirmation button is pressed.
///The returned value is used as the data property of the [AdaptiveProgressDialogResult].
///[cancelButtonCallback] A function that returns a Future<void> and is called when the cancel button is pressed.
///[adaptiveProgressDialogStyle] An object of AdaptiveProgressDialogStyle which contains styles for the progress dialog on different platforms.
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

  /// Title of the dialog
  final String? title;

  /// Content of the dialog
  final String? content;

  /// Label of the confirmation button - 'Ok' by default
  final String? confirmationButtonLabel;

  /// Label of the cancel button - 'Cancel' by default
  final String? cancelButtonLabel;

  /// Confirmation button callback
  /// This method is triggered when the confirmation button is pressed.
  /// Once finished the dialog is closed and the result is returned via [AdaptiveProgressDialogResult]
  final Future<T?> Function()? confirmButtonCallback;

  /// Cancel button callback
  /// This method is triggered when the cancel button is pressed.
  /// Should be used if there is need to do some actions before the dialog is closed after cancel button is pressed
  final Future<void> Function()? cancelButtonCallback;

  ///The dialog can be styled using the [AdaptiveProgressDialogStyle]
  ///If null is passed the default theme is applied
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

  ///Check if cupertino dialog should be shown
  bool get _shouldBuildCupertino =>
      kIsWeb ? false : Platform.isIOS || Platform.isMacOS;

  ///Method that is called when the cancel button is pressed
  ///First the cancelButtonCallback is called - if provided
  ///Next the dialog is closed and the [AdaptiveProgressDialogResult]
  ///is returned either with Canceled or Error status
  Future<void> _onCancelPressed(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      await cancelButtonCallback?.call();
      navigator.pop(AdaptiveProgressDialogResult<T?>.canceled());
    } catch (_) {
      AdaptiveProgressDialogResult<T?>.error();
    }
  }

  ///Method that is called when the confirmation button is pressed
  ///First the confirmButtonCallback is called - if provided
  ///Next the dialog is closed and the [AdaptiveProgressDialogResult]
  ///is returned either with Success or Error status.
  ///If the status is Success and the callback returns data
  ///of type T then the data is available in [data] property of [AdaptiveProgressDialogResult]
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
