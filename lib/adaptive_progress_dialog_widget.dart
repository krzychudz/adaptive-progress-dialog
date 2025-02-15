import 'package:flutter/material.dart';

import 'adaptive_progress_dialog_result.dart';
import 'adaptive_progress_dialog_style.dart';
import 'dialog/progress_dialog.dart';

class AdaptiveProgressDialog<T> {
  ///This is a class that provides an easy way to show a progress dialog with an adaptive
  ///
  ///style depending on the platform. The widget is generic and takes a type parameter
  ///
  ///[T] which is used to represent the data that can be returned from the dialog.
  ///
  ///The data is returned via [AdaptiveProgressDialogResult] class.
  AdaptiveProgressDialog({
    required this.title,
    required this.content,
    this.confirmationButtonLabel,
    this.cancelButtonLabel,
    this.adaptiveProgressDialogStyle,
    this.confirmButtonCallback,
    this.isDismissible = true,
  });

  ///Dialog's title
  final String title;

  ///Dialog's content
  final String content;

  ///Confirmation button's label - 'Ok' by default
  final String? confirmationButtonLabel;

  ///Cancel button's label - 'Cancel' by default
  final String? cancelButtonLabel;

  ///Callback that is called when confirmation button is pressed.
  ///
  ///If the callback returns a data of type T, the data will
  ///be available via [AdaptiveProgressDialogResult] in [data] property.
  ///
  ///If the callback fails the [AdaptiveProgressDialogResult] with error status is returned from dialog.
  final Future<T?> Function()? confirmButtonCallback;

  ///The dialog can be styled using the [AdaptiveProgressDialogStyle]
  ///
  ///If null is passed the default theme is applied
  final AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle;

  ///If the dialog is dismissible by the clicking outside the dialog --- true by default
  final bool isDismissible;

  ///This method is used to display the progress dialog.
  ///
  ///This method returns `Future<AdaptiveProgressDialogResult<T?>>`.
  ///
  ///The method can be awaited to get the dialog result data.
  ///
  ///Possible states are:
  ///
  ///* [AdaptiveProgressDialogResult] with 'Success' status and data of type T returned from [confirmButtonCallback].
  ///
  ///* [AdaptiveProgressDialogResult] with 'Canceled' status if the dialog was closed used Cancel button.
  ///
  ///* [AdaptiveProgressDialogResult] with 'Error' status if the [confirmButtonCallback] or [cancelButtonCallback] failed.
  ///
  ///* [AdaptiveProgressDialogResult] with 'Closed' status if the dialog was class by tapping outside the dialog.
  Future<AdaptiveProgressDialogResult<T?>> show(BuildContext context) async {
    final result = await showDialog<AdaptiveProgressDialogResult<T?>>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => ProgressDialog(
        title: title,
        content: content,
        confirmationButtonLabel: confirmationButtonLabel,
        cancelButtonLabel: cancelButtonLabel,
        confirmButtonCallback: confirmButtonCallback,
        adaptiveProgressDialogStyle: adaptiveProgressDialogStyle,
      ),
    );

    if (result == null) return AdaptiveProgressDialogResult.closed();
    return result;
  }
}
