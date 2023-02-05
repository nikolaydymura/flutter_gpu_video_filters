part of flutter_gpu_video_filters;

class GPUSobelThresholdConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _threshold;

  GPUSobelThresholdConfiguration()
      : _threshold = _FloatParameter('inputThreshold', 'Threshold', 0),
        super('SobelThreshold');

  set intensity(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold, _image2];
}
