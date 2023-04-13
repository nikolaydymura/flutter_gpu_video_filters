part of flutter_gpu_video_filters;

/// Describes monochrome manipulations
class GPUMonochromeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final ColorParameter _color;

  GPUMonochromeConfiguration()
      : _intensity = GLSliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1,
          min: 0,
          max: 1,
        ),
        _color = GLColorParameter(
          'inputColor',
          'Color',
          const Color.fromRGBO(153, 115, 76, 1.0),
        ),
        super('Monochrome');

  /// Updates the [intensity] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Updates the [color] value.
  ///
  /// The [value] must be three channels each in the range 0.0 to 255.0.
  set color(Color value) {
    _color.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _color];
}
