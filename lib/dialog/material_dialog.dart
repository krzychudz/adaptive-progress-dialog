import 'package:adaptive_progress_dialog/dialog/content.dart';
import 'package:flutter/material.dart';

class MaterialDialog extends StatelessWidget {
  const MaterialDialog({
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
    return AlertDialog(
      title: Text(title ?? ''),
      content: DialogContent(
        isProgressBarVisible: isProgressVisible,
        title: title,
        content: content,
      ),
      actionsPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      actions: dialogActions,
    );
  }

  List<TextButton> get dialogActions => [
        TextButton(
          onPressed: onCancelPressed,
          child: Text(cancelButtonLabel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: onActionButtonPressed,
          child: Text(actionButtonLabel ?? 'Ok'),
        ),
      ];
}
