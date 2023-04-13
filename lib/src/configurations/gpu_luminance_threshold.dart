part of flutter_gpu_video_filters;

/// Describes luminance threshold manipulations
class GPULuminanceThresholdConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPULuminanceThresholdConfiguration()
      : _threshold = GLFloatParameter(
          'inputThreshold',
          'Threshold',
          0.5,
        ),
        super('LuminanceThreshold');

  /// Updates the [threshold] value.
  set threshold(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
