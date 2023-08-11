part of flutter_gpu_video_filters;

/// Describes brightness manipulations
class GPUBrightnessConfiguration extends GPUFilterConfiguration {
  final NumberParameter _brightness;

  GPUBrightnessConfiguration()
      : _brightness = GLSliderFloatParameter(
          'inputBrightness',
          'Brightness',
          0,
          min: -1,
          max: 1,
        ),
        super('Brightness');

  /// Updates the [brightness] value.
  ///
  /// The [value] must be in -1.0 and 1.0 range.
  set brightness(double value) {
    _brightness.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_brightness];
}
