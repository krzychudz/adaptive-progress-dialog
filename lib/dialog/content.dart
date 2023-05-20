import 'package:flutter/material.dart';

class DialogProgressContent extends StatelessWidget {
  const DialogProgressContent({
    super.key,
    this.isActionInProgress = false,
    this.contentText,
    this.contentTextStyle,
  });

  final bool isActionInProgress;
  final String? contentText;
  final TextStyle? contentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          contentText ?? '',
          style: contentTextStyle,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: isActionInProgress
              ? const Column(
                  children: [
                    SizedBox(height: 16),
                    CircularProgressIndicator.adaptive(),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
