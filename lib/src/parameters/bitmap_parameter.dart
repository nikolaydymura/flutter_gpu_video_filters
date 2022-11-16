part of gpu_video_filters;

class _BitmapParameter extends DataParameter {
  _BitmapParameter(super.name, super.displayName);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (asset != null) {
      await GPUFilterConfiguration._api
          .updateParameter(configuration._filterId, name, asset);
    } else if (file != null) {
      await GPUFilterConfiguration._api
          .updateParameter(configuration._filterId, name, file?.absolute.path);
    } else if (data != null) {
      await GPUFilterConfiguration._api
          .updateParameter(configuration._filterId, name, data);
    }
  }
}
