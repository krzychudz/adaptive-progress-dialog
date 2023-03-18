import 'package:adaptive_progress_dialog/dialog/content.dart';
import 'package:flutter/material.dart';

import '../adaptive_progress_dialog.dart';

class MaterialDialog extends StatelessWidget {
  const MaterialDialog({
    required this.isProgressVisible,
    required this.onCancelPressed,
    required this.onActionButtonPressed,
    super.key,
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
    return AlertDialog(
      title: Text(title ?? ''),
      titleTextStyle: adaptiveProgressDialogStyle?.titleTextStyle,
      content: DialogContent(
        isProgressBarVisible: isProgressVisible,
        title: title,
        content: content,
      ),
      contentTextStyle: adaptiveProgressDialogStyle?.contentTextStyle,
      contentPadding: contentPadding,
      actionsPadding: adaptiveProgressDialogStyle?.materialActionsPadding,
      actions: dialogActions,
      actionsAlignment: adaptiveProgressDialogStyle?.materialActionsAlignment,
    );
  }

  EdgeInsets? get contentPadding =>
      adaptiveProgressDialogStyle?.materialContentPadding ??
      const EdgeInsets.only(top: 16, right: 24, left: 24, bottom: 0);

  List<TextButton> get dialogActions => [
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            cancelButtonLabel ?? 'Cancel',
            style: adaptiveProgressDialogStyle?.cancelButtonTextStyle,
          ),
        ),
        TextButton(
          onPressed: onActionButtonPressed,
          child: Text(
            actionButtonLabel ?? 'Ok',
            style: adaptiveProgressDialogStyle?.confirmButtonTextStyle,
          ),
        ),
      ];
}
