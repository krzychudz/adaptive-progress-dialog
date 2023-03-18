import 'package:adaptive_progress_dialog/dialog/content.dart';
import 'package:flutter/cupertino.dart';

class CupertinoDialog extends StatelessWidget {
  const CupertinoDialog({
    super.key,
    this.title,
    this.content,
    this.actionButtonLabel,
    this.actionButtonCallback,
    this.cancelButtonLabel,
    required this.isProgressVisible,
    required this.onCancelPressed,
    required this.onActionButtonPressed,
  });

  final String? title;
  final String? content;
  final String? actionButtonLabel;
  final Function()? actionButtonCallback;
  final bool isProgressVisible;
  final Function() onCancelPressed;
  final Function() onActionButtonPressed;
  final String? cancelButtonLabel;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: DialogContent(
        isProgressBarVisible: isProgressVisible,
        title: title,
        content: content,
      ),
      actions: dialogActions,
    );
  }

  List<CupertinoDialogAction> get dialogActions => [
        CupertinoDialogAction(
          onPressed: onCancelPressed,
          child: Text(cancelButtonLabel ?? 'Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: onActionButtonPressed,
          child: Text(actionButtonLabel ?? 'Ok'),
        ),
      ];
}
