part of flutter_gpu_video_filters;

class _SliderFloatParameter extends RangeNumberParameter with _NumberParameter {
  _SliderFloatParameter(
    super.name,
    super.displayName,
    super.value, {
    super.min,
    super.max,
  });

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

class _ColorIntensityParameter extends _SliderFloatParameter
    with _NumberParameter {
  _ColorIntensityParameter(
    super.shaderName,
    super.displayName,
    super.value, {
    super.min,
    super.max,
  });

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }

  @override
  double get floatValue => value.toDouble() / 255.0;
}
