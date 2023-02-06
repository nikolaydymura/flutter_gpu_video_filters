part of flutter_gpu_video_filters;

class _AspectRatioParameter extends AspectRatioParameter {
  _AspectRatioParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      value.width / value.height,
    );
  }
}
