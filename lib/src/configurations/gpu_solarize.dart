part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Solarize filter
class GPUSolarizeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPUSolarizeConfiguration()
    : _threshold = GLFloatParameter('inputThreshold', 'Threshold', 0.5),
      super('Solarize');

  /// Threshold value
  ///
  /// The default value is 0.5
  set threshold(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
