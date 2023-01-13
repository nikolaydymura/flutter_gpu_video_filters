part of flutter_gpu_video_filters;

class GPUToneConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;
  final NumberParameter _quantizationLevels;

  GPUToneConfiguration()
      : _threshold = _FloatParameter(
          'inputThreshold',
          'Threshold',
          0.2,
        ),
        _quantizationLevels = _FloatParameter(
          'inputQuantizationLevels',
          'QuantizationLevels',
          10,
        ),
        super('Tone');

  set threshold(double value) {
    _threshold.value = value;
  }

  set quantizationLevels(double value) {
    _quantizationLevels.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_threshold, _quantizationLevels];
}
