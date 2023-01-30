part of flutter_gpu_video_filters;

class _FloatParameter extends NumberParameter {
  _FloatParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      value.toDouble(),
    );
  }
}
