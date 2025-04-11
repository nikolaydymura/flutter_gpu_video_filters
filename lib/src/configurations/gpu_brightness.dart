part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Brightness filter
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

  /// Set the brightness
  ///
  /// The default value is `0`
  set brightness(double value) {
    _brightness.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_brightness];
}
