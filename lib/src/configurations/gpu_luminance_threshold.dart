part of flutter_gpu_video_filters;

class GPULuminanceThresholdConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPULuminanceThresholdConfiguration()
      : _threshold = _FloatParameter(
          'inputThreshold',
          'Threshold',
          0.5,
        ),
        super('LuminanceThreshold');

  set hue(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
