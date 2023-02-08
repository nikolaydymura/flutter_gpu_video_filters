part of flutter_gpu_video_filters;

class _Vec3Parameter extends ListParameter {
  _Vec3Parameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      floats64,
    );
  }
}
