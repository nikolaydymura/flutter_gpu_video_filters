part of flutter_gpu_video_filters;

/// Describes contrast manipulations
class GPUContrastConfiguration extends GPUFilterConfiguration {
  final NumberParameter _contrast;

  GPUContrastConfiguration()
      : _contrast = GLSliderFloatParameter(
          'inputContrast',
          'Contrast',
          1.2,
          min: 0,
          max: 4,
        ),
        super('Contrast');

  /// Updates the [contrast] value.
  ///
  /// The [value] must be in 0.0 and 4.0 range.
  set contrast(double value) {
    _contrast.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_contrast];
}
