import 'package:adaptive_progress_dialog/adaptive_progress_dialog_style.dart';
import 'package:adaptive_progress_dialog/dialog/content.dart';
import 'package:flutter/cupertino.dart';

class CupertinoDialog extends StatelessWidget {
  const CupertinoDialog({
    super.key,
    required this.isActionInProgress,
    required this.onCancelPressed,
    required this.onActionButtonPressed,
    this.title,
    this.content,
    this.confirmationButtonLabel,
    this.cancelButtonLabel,
    this.adaptiveProgressDialogStyle,
  });

  final String? title;
  final String? content;
  final String? confirmationButtonLabel;
  final bool isActionInProgress;
  final String? cancelButtonLabel;
  final AdaptiveProgressDialogStyle? adaptiveProgressDialogStyle;
  final Function() onCancelPressed;
  final Function() onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title ?? '',
        style: adaptiveProgressDialogStyle?.titleTextStyle,
      ),
      content: DialogProgressContent(
        isActionInProgress: isActionInProgress,
        contentText: content,
        contentTextStyle: adaptiveProgressDialogStyle?.contentTextStyle,
      ),
      actions: dialogActions,
    );
  }

  List<CupertinoDialogAction> get dialogActions => [
        CupertinoDialogAction(
          onPressed: onCancelPressed,
          textStyle: adaptiveProgressDialogStyle?.cancelButtonTextStyle,
          child: Text(cancelButtonLabel ?? 'Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: isActionInProgress ? null : onActionButtonPressed,
          textStyle: adaptiveProgressDialogStyle?.confirmButtonTextStyle,
          child: Text(confirmationButtonLabel ?? 'Ok'),
        ),
      ];
}
