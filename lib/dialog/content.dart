import 'package:flutter/material.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
    this.isProgressBarVisible = false,
    this.title,
    this.content,
    this.contentTextStyle,
  });

  final bool isProgressBarVisible;
  final String? title;
  final String? content;
  final TextStyle? contentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          content ?? '',
          style: contentTextStyle,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: isProgressBarVisible
              ? Column(
                  children: const [
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
