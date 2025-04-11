part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Hue filter
class GPUHueConfiguration extends GPUFilterConfiguration {
  final NumberParameter _hue;

  GPUHueConfiguration()
    : _hue = GLHueParameter('inputHueAdjust', 'Hue Adjust', 90.0),
      super('Hue');

  /// Hue value
  ///
  /// Default value is 90.0
  set hue(double value) {
    _hue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_hue];
}
