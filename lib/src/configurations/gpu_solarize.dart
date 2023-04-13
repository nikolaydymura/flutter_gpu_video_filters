part of flutter_gpu_video_filters;

/// Describes solarize manipulations
class GPUSolarizeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPUSolarizeConfiguration()
      : _threshold = GLFloatParameter(
          'inputThreshold',
          'Threshold',
          0.5,
        ),
        super('Solarize');

  /// Updates the [threshold] value.
  set threshold(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
