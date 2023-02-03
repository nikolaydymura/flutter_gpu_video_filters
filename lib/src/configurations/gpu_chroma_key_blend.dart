part of flutter_gpu_video_filters;

class GPUChromaKeyBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _thresholdSensitivity;
  final NumberParameter _smoothing;

  GPUChromaKeyBlendConfiguration()
      : _thresholdSensitivity = _FloatParameter(
          'inputThresholdSensitivity',
          'Threshold Sensitivity',
          0.4,
        ),
        _smoothing = _FloatParameter(
          'inputSmoothing',
          'Smoothing',
          0.1,
        ),
        super('ChromaKeyBlend');

  set thresholdSensitivity(double value) {
    _thresholdSensitivity.value = value;
  }

  set smoothing(double value) {
    _smoothing.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_thresholdSensitivity, _smoothing, _image2];
}
