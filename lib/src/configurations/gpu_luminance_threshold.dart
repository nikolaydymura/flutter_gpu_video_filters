part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the LuminanceThreshold filter
class GPULuminanceThresholdConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPULuminanceThresholdConfiguration()
    : _threshold = GLFloatParameter('inputThreshold', 'Threshold', 0.5),
      super('LuminanceThreshold');

  /// The threshold value to apply to the luminance of the image
  ///
  /// The default value is 0.5
  set threshold(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
