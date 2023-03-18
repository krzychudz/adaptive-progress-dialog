enum DialogStatus { success, canceled, error }

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

  factory AdaptiveProgressDialogResult.success(T? data) =>
      AdaptiveProgressDialogResult(status: DialogStatus.success);
}
