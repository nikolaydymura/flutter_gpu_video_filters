part of flutter_gpu_video_filters;

class _SliderFloatParameter extends RangeNumberParameter {
  _SliderFloatParameter(
    super.name,
    super.displayName,
    super.value, {
    super.min,
    super.max,
  });

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      value.toDouble(),
    );
  }
}
