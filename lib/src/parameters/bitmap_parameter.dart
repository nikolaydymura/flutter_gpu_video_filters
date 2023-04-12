part of flutter_gpu_video_filters;

/// Describes Bitmap Parameter updating
@visibleForTesting
class GLBitmapParameter extends DataParameter {
  GLBitmapParameter(super.name, super.displayName);

  /// Updates the Bitmap Parameter value.
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    if (asset != null) {
      await configuration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        true,
        asset!,
      );
    } else if (file != null) {
      await configuration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        false,
        file!.absolute.path,
      );
    } else if (data != null) {
      await configuration._api.setBitmapParameter(
        configuration._filterId,
        name,
        data!,
      );
    }
  }
}
