enum DialogStatus { success, canceled, error, closed }

class AdaptiveProgressDialogResult<T> {
  ///The [AdaptiveProgressDialogResult] class represents the result of the dialog shown by the [AdaptiveProgressDialog] widget.
  ///
  ///It contains a [status] property and an optional [data] property.
  ///
  ///The [status] property indicates the status of the dialog using the [DialogStatus] enum:
  ///
  ///*[DialogStatus.success] if the async confirmation callback succeed.
  ///
  ///*[DialogStatus.canceled] if the dialog was closed using cancel button.
  ///
  ///*[DialogStatus.closed] if the dialog was closed just by clicking outside it.
  ///
  ///*[DialogStatus.error] if the dialog was closed with error that comes from [confirmButtonCallback].
  ///
  ///Factories:
  ///
  ///*[AdaptiveProgressDialogResult.canceled()] A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to canceled.
  ///
  ///*[AdaptiveProgressDialogResult.error()] A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to error.
  ///
  ///*[AdaptiveProgressDialogResult.closed()] A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to closed.
  ///
  ///*[AdaptiveProgressDialogResult.success(T? data)] A factory method that creates a [AdaptiveProgressDialogResult]
  ///object with the status set to success and the data property set to the provided value.
  AdaptiveProgressDialogResult({
    this.status = DialogStatus.success,
    this.data,
    this.error,
  });

  final DialogStatus status;
  final T? data;
  final dynamic error;

  ///A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to canceled.
  factory AdaptiveProgressDialogResult.canceled() =>
      AdaptiveProgressDialogResult(status: DialogStatus.canceled);

  ///A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to error and the error object.
  factory AdaptiveProgressDialogResult.error(dynamic error) =>
      AdaptiveProgressDialogResult(status: DialogStatus.error, error: error);

  ///A factory method that creates a [AdaptiveProgressDialogResult] object with the status set to closed.
  factory AdaptiveProgressDialogResult.closed() =>
      AdaptiveProgressDialogResult(status: DialogStatus.closed);

  ///A factory method that creates a [AdaptiveProgressDialogResult]
  ///object with the status set to success and the data property set to the provided value.
  factory AdaptiveProgressDialogResult.success(T? data) =>
      AdaptiveProgressDialogResult(status: DialogStatus.success, data: data);
}
