part of '../../flutter_gpu_video_filters.dart';

/// Slider float parameter for GPU filters
///
/// This parameter is used to pass float values to the GPU as `uniform float` variables.
@visibleForTesting
class GLSliderFloatParameter extends RangeNumberParameter {
  /// Create a [GLSliderFloatParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  /// [min] is the minimum value
  /// [max] is the maximum value
  GLSliderFloatParameter(
    super.name,
    super.displayName,
    super.value, {
    super.min,
    super.max,
  });

  /// Apply updates to the GPU filter
  ///
  /// [configuration] is the connected GPU filter configuration
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await configuration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

@visibleForTesting
class GLSliderComputeFloatParameter extends RangeNumberParameter {
  VoidCallback? onChange;
  FutureOr<void> Function(GPUFilterConfiguration)? onUpdate;

  GLSliderComputeFloatParameter(
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

@visibleForTesting
class GLColorIntensityParameter extends GLSliderFloatParameter {
  GLColorIntensityParameter(super.shaderName, super.displayName, super.value)
    : super(min: 0, max: 255);

  @override
  double get floatValue => value.toDouble() / 255.0;
}
