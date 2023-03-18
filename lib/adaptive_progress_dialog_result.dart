enum DialogStatus { success, canceled, error, closed }

class AdaptiveProgressDialogResult<T> {
  AdaptiveProgressDialogResult({
    this.status = DialogStatus.success,
    this.data,
  });

  final DialogStatus status;
  final T? data;

  factory AdaptiveProgressDialogResult.canceled() =>
      AdaptiveProgressDialogResult(status: DialogStatus.canceled);

  factory AdaptiveProgressDialogResult.error() =>
      AdaptiveProgressDialogResult(status: DialogStatus.error);

  factory AdaptiveProgressDialogResult.closed() =>
      AdaptiveProgressDialogResult(status: DialogStatus.closed);

  factory AdaptiveProgressDialogResult.success(T? data) =>
      AdaptiveProgressDialogResult(status: DialogStatus.success, data: data);
}
