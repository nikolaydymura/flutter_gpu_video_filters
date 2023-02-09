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

class _SliderComputeFloatParameter extends RangeNumberParameter {
  VoidCallback? onChange;
  FutureOr<void> Function(GPUFilterConfiguration)? onUpdate;

  _SliderComputeFloatParameter(
    super.name,
    super.displayName,
    super.value, {
    super.min,
    super.max,
  }) : super(compute: true);

  @override
  set value(num value) {
    super.value = value;
    onChange?.call();
  }

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) =>
      onUpdate?.call(configuration);
}

class _ColorIntensityParameter extends _SliderFloatParameter {
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
