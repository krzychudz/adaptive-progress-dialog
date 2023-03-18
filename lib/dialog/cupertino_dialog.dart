import 'package:adaptive_progress_dialog/dialog/content.dart';
import 'package:flutter/cupertino.dart';

import '../adaptive_progress_dialog.dart';

class CupertinoDialog extends StatelessWidget {
  const CupertinoDialog({
    super.key,
    required this.isProgressVisible,
    required this.onCancelPressed,
    required this.onActionButtonPressed,
    this.title,
    this.content,
    this.actionButtonLabel,
    this.cancelButtonLabel,
    this.adaptiveProgressDialogStyle,
  });

  final String? title;
  final String? content;
  final String? actionButtonLabel;
  final bool isProgressVisible;
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
      content: DialogContent(
        isProgressBarVisible: isProgressVisible,
        title: title,
        content: content,
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
          onPressed: onActionButtonPressed,
          textStyle: adaptiveProgressDialogStyle?.confirmButtonTextStyle,
          child: Text(actionButtonLabel ?? 'Ok'),
        ),
      ];
}
