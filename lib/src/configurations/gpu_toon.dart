part of '../../flutter_gpu_video_filters.dart';

class GPUToonConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final NumberParameter _threshold;
  final NumberParameter _quantizationLevels;

  GPUToonConfiguration()
      : _threshold = GLFloatParameter(
          'inputThreshold',
          'Threshold',
          0.2,
        ),
        _quantizationLevels = GLFloatParameter(
          'inputQuantizationLevels',
          'Quantization Levels',
          10,
        ),
        super('Toon');

  set threshold(double value) {
    _threshold.value = value;
  }

  set quantizationLevels(double value) {
    _quantizationLevels.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_threshold, _quantizationLevels, ...super.parameters];
}
