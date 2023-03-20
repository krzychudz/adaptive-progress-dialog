import 'dart:async';
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
///[adaptiveProgressDialogStyle] An object of AdaptiveProgressDialogStyle which contains styles for the progress dialog on different platforms.
class ProgressDialog<T> extends StatefulWidget {
  const ProgressDialog({
    super.key,
    this.title,
    this.content,
    this.confirmationButtonLabel,
    this.cancelButtonLabel,
    this.confirmButtonCallback,
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

  ///The dialog can be styled using the [AdaptiveProgressDialogStyle]
  ///If null is passed the default theme is applied
  final AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle;

  @override
  State<ProgressDialog<T>> createState() => _ProgressDialogState<T>();
}

class _ProgressDialogState<T> extends State<ProgressDialog<T>> {
  bool isActionInProgress = false;
  bool isClosed = false;

  StreamSubscription<T?>? actionStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return _shouldBuildCupertino
        ? CupertinoDialog(
            title: widget.title,
            content: widget.content,
            confirmationButtonLabel: widget.confirmationButtonLabel,
            onCancelPressed: () async {
              await _onCancelPressed(context);
              setState(() => isClosed = true);
            },
            isActionInProgress: isActionInProgress,
            onActionButtonPressed: () async {
              setState(() => isActionInProgress = true);
              await _onConfirmationButtonPressed(context);
            },
            adaptiveProgressDialogStyle: widget.adaptiveProgressDialogStyle,
          )
        : MaterialDialog(
            title: widget.title,
            content: widget.content,
            confirmationButtonLabel: widget.confirmationButtonLabel,
            cancelButtonLabel: widget.cancelButtonLabel,
            onCancelPressed: () async {
              await _onCancelPressed(context);
              setState(() => isClosed = true);
            },
            isActionInProgress: isActionInProgress,
            onActionButtonPressed: () async {
              setState(() => isActionInProgress = true);
              await _onConfirmationButtonPressed(context);
            },
            adaptiveProgressDialogStyle: widget.adaptiveProgressDialogStyle,
          );
  }

  ///Check if cupertino dialog should be shown
  bool get _shouldBuildCupertino =>
      kIsWeb ? false : Platform.isIOS || Platform.isMacOS;

  ///Method that is called when the cancel button is pressed
  ///First the cancelButtonCallback is called - if provided
  ///Next the dialog is closed and the [AdaptiveProgressDialogResult]
  ///is returned Canceled status
  Future<void> _onCancelPressed(BuildContext context) async {
    actionStreamSubscription?.cancel();
    Navigator.of(context).pop(AdaptiveProgressDialogResult<T?>.canceled());
  }

  ///Method that is called when the confirmation button is pressed
  ///First the confirmButtonCallback is called - if provided
  ///Next the dialog is closed and the [AdaptiveProgressDialogResult]
  ///is returned either with Success or Error status.
  ///If the status is Success and the callback returns data
  ///of type T then the data is available in [data] property of [AdaptiveProgressDialogResult]
  Future<void> _onConfirmationButtonPressed(BuildContext context) async {
    final confirmationCallback = widget.confirmButtonCallback;

    if (confirmationCallback != null) {
      final actionCallbackStream = Stream.fromFuture(confirmationCallback());
      actionStreamSubscription = actionCallbackStream
          .listen((data) => _onConfirmationCallbackSuccess(context, data))
        ..onError((error, stackTrace) =>
            _onConfirmationCallbackError(context, error));
    }
  }

  void _onConfirmationCallbackSuccess(BuildContext context, T? data) {
    Navigator.of(context).pop(AdaptiveProgressDialogResult<T?>.success(data));
  }

  void _onConfirmationCallbackError(BuildContext context, dynamic error) {
    Navigator.of(context).pop(AdaptiveProgressDialogResult<T?>.error(error));
  }
}
