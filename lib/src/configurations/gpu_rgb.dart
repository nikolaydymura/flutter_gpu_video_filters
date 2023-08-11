part of flutter_gpu_video_filters;

/// Describes rgb manipulations
class GPURGBConfiguration extends GPUFilterConfiguration {
  final NumberParameter _red;
  final NumberParameter _green;
  final NumberParameter _blue;

  GPURGBConfiguration()
      : _red = GLColorIntensityParameter(
          'inputRed',
          'Red',
          255,
        ),
        _green = GLColorIntensityParameter(
          'inputGreen',
          'Green',
          255,
        ),
        _blue = GLColorIntensityParameter(
          'inputBlue',
          'Blue',
          255,
        ),
        super('RGB');

  /// Updates the [red] value.
  ///
  /// The [value] must be in 0.0 and 255.0 range.
  set red(double value) {
    _red.value = value;
  }

  /// Updates the [green] value.
  ///
  /// The [value] must be in 0.0 and 255.0 range.
  set green(double value) {
    _green.value = value;
  }

  /// Updates the [blue] value.
  ///
  /// The [value] must be in 0.0 and 255.0 range.
  set blue(double value) {
    _blue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_red, _green, _blue];
}
