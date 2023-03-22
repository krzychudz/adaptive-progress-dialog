# Adaptive Progress Dialog

A Flutter package that provides an easy way to show a progress dialog with an adaptive style depending on the platform.

The AdaptiveProgressDialog widget is generic and takes a type parameter T which is used to represent the data that can be returned from the async opration performed by dialog. The data is returned via the AdaptiveProgressDialogResult class.

## Usage
Add the package to your pubspec.yaml file:

```
dependencies:
  adaptive_progress_dialog: ^1.0.0
```

Import the package in your Dart code:

```
import 'package:adaptive_progress_dialog/adaptive_progress_dialog.dart';
```

Create an instance of the AdaptiveProgressDialog class:

```
final progressDialog = AdaptiveProgressDialog<String>(
  title: 'Progress Dialog',
  content: 'Please wait...',
  confirmationButtonLabel: 'Confirm',
  cancelButtonLabel: 'Cancel',
  confirmButtonCallback: () async {
    // Perform some async operation here
    return 'Operation completed successfully';
  },
);
```
Call the show method to display the progress dialog:

```
final result = await progressDialog.show(context);
```

The show method returns a Future<AdaptiveProgressDialogResult<T?>> that can be awaited to get the dialog result data. Possible states are:

+ AdaptiveProgressDialogResult with 'Success' status and data of type T returned from confirmButtonCallback.
+ AdaptiveProgressDialogResult with 'Canceled' status if the dialog was closed using the Cancel button.
+ AdaptiveProgressDialogResult with 'Error' status if the confirmButtonCallback or cancelButtonCallback failed.
+ AdaptiveProgressDialogResult with 'Closed' status if the dialog was closed by tapping outside the dialog.

For example:

```
final progressDialog = AdaptiveProgressDialog<String>(
  title: 'Progress Dialog',
  content: 'Please wait...',
  confirmationButtonLabel: 'Confirm',
  cancelButtonLabel: 'Cancel',
  confirmButtonCallback: () async {
    // Perform some async operation here
    return 'Operation completed successfully';
  },
);

final dialogResult = await progressDialog.show(context);


if (dialogResult.status ==  DialogStatus.success) {
  final data = dialogResult.data;
}
```

When the confiramtion button is pressed, the confirmButtonCallback is triggered and progress indicator shows up. 
After the async operation is done, the dialog is closed and the data is available via AdaptiveProgressDialogResult as shown above.

## Parameters
The AdaptiveProgressDialog widget has the following parameters:

```
title: The dialog's title.
content: The dialog's content.
confirmationButtonLabel: The label for the confirmation button. Defaults to 'Ok'.
cancelButtonLabel: The label for the cancel button. Defaults to 'Cancel'.
confirmButtonCallback: The callback that is called when the confirmation button is pressed. If the callback returns a data of type T, the data will be available via AdaptiveProgressDialogResult in the data property. If the callback fails, an AdaptiveProgressDialogResult with error status is returned from the dialog. adaptiveProgressDialogStyle: The dialog can be styled using the AdaptiveProgressDialogStyle. If null is passed, the default theme is applied.
isDismissible: If the dialog is dismissible by clicking outside the dialog. True by default.
```

## Styling
The dialog can be styled via adaptiveProgressDialogStyle parameter. To use it just pass the AdaptiveProgressDialogStyle object to it.
If not provided the default styles are applied - accroding to the Flutter default styling of the MaterialDialog and CupertinoDialog widgets.

```
titleTextStyle - defines the title text style.
contentTextStyle - defines the content text style.
confirmButtonTextStyle - defines the confirmation button text style.
cancelButtonTextStyle - defines the cancel button text style.
materialContentPadding - defines the content padding of the dialog (only for Material Dialog - ignored for Cupertino).
materialActionsPadding - defines the action buttons padding of the dialog (only for Material Dialog - ignored for Cupertino).
materialActionsAlignment - defines the action buttons alignment of the dialog (only for Material Dialog - ignored for Cupertino).
```
For example:

```
AdaptiveProgressDialog(
  title: 'Loading',
  content: 'Please wait...',
  adaptiveProgressDialogStyle: AdaptiveProgressDialogStyle(
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.grey,
    ),
    confirmButtonTextStyle: TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
    cancelButtonTextStyle: TextStyle(
      fontSize: 20.0,
      color: Colors.red,
    ),
    materialContentPadding: EdgeInsets.all(16.0),
    materialActionsPadding: EdgeInsets.only(right: 8.0, bottom: 8.0),
    materialActionsAlignment: MainAxisAlignment.end,
  ),
  confirmButtonCallback: () async {
    // Do some work here...
  },
);
```
