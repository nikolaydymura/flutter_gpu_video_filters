part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the RGB filter
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

  /// Red intensity
  ///
  /// Range: 0.0 - 255.0
  set red(double value) {
    _red.value = value;
  }

  /// Green intensity
  ///
  /// Range: 0.0 - 255.0
  set green(double value) {
    _green.value = value;
  }

  /// Blue intensity
  ///
  /// Range: 0.0 - 255.0
  set blue(double value) {
    _blue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_red, _green, _blue];
}
