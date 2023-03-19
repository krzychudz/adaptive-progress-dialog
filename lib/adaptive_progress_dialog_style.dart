import 'package:flutter/material.dart';

class AdaptiveProgressDialogStyle {
  ///This is a class that defines the style for the AdaptiveProgressDialog widget.
  ///
  ///It contains properties for customizing the visual appearance of the dialog such as text styles and padding.
  ///
  ///Serval properties of the dialog can be customized:
  ///
  ///* [titleTextStyle] - defines a title text style
  ///
  ///* [contentTextStyle] - defines a content text style
  ///
  ///* [confirmButtonTextStyle] - defines a confirmation button text style
  ///
  ///* [cancelButtonTextStyle] - defines a cancel button text style
  ///
  ///* [materialContentPadding] - defines a content padding - only for Material Dialog - ignored for Cupertino
  ///
  ///* [materialActionsPadding] - defines a action buttons padding - only for Material Dialog - ignored for Cupertino
  ///
  ///* [materialActionsAlignment] - defines a action buttons alignment - only for Material Dialog - ignored for Cupertino
  AdaptiveProgressDialogStyle({
    this.titleTextStyle,
    this.contentTextStyle,
    this.confirmButtonTextStyle,
    this.cancelButtonTextStyle,
    this.materialContentPadding,
    this.materialActionsPadding,
    this.materialActionsAlignment,
  });

  /// Dialog's title text style
  final TextStyle? titleTextStyle;

  /// Dialog's content text style
  final TextStyle? contentTextStyle;

  /// Dialog's confirmation button label text style
  final TextStyle? confirmButtonTextStyle;

  /// Dialog's cancel button label text style
  final TextStyle? cancelButtonTextStyle;

  /// Dialog's content padding label text style - Only for Material Dialog
  final EdgeInsets? materialContentPadding;

  /// Dialog's action buttons padding label text style - Only for Material Dialog
  final EdgeInsets? materialActionsPadding;

  /// Dialog's action buttons alignment label text style - Only for Material Dialog
  final MainAxisAlignment? materialActionsAlignment;
}
