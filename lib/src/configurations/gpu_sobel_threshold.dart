part of flutter_gpu_video_filters;

/// Describes Sobel threshold manipulations
class GPUSobelThresholdConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final NumberParameter _threshold;

  GPUSobelThresholdConfiguration()
      : _threshold = GLFloatParameter('inputThreshold', 'Threshold', 0.9),
        super('SobelThreshold');

  /// Updates the [intensity] value.
  set intensity(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _threshold];
}
