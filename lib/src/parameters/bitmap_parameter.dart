part of flutter_gpu_video_filters;

class _BitmapParameter extends DataParameter {
  _BitmapParameter(super.name, super.displayName);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    if (asset != null) {
      await GPUFilterConfiguration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        true,
        asset!,
      );
    } else if (file != null) {
      await GPUFilterConfiguration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        false,
        file!.absolute.path,
      );
    } else if (data != null) {
      await GPUFilterConfiguration._api.setBitmapParameter(
        configuration._filterId,
        name,
        data!,
      );
    }
  }
}
