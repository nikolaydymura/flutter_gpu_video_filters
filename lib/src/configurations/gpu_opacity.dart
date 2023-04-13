part of flutter_gpu_video_filters;

/// Describes opacity manipulations
class GPUOpacityConfiguration extends GPUFilterConfiguration {
  final NumberParameter _opacity;

  GPUOpacityConfiguration()
      : _opacity = GLSliderFloatParameter(
          'inputOpacity',
          'Opacity',
          1,
          min: 0,
          max: 1,
        ),
        super('Opacity');

  /// Updates the [brightness] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set opacity(double value) {
    _opacity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_opacity];
}
