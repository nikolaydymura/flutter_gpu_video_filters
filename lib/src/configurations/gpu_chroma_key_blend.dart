part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the ChromaKeyBlend filter
class GPUChromaKeyBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _thresholdSensitivity;
  final NumberParameter _smoothing;
  final ColorParameter _colorToReplace;

  GPUChromaKeyBlendConfiguration()
    : _thresholdSensitivity = GLFloatParameter(
        'inputThresholdSensitivity',
        'Threshold Sensitivity',
        0.4,
      ),
      _smoothing = GLFloatParameter('inputSmoothing', 'Smoothing', 0.1),
      _colorToReplace = GLColorParameter(
        'inputColorToReplace',
        'Color To Replace',
        const Color.fromRGBO(0, 255, 0, 1.0),
      ),
      super('ChromaKeyBlend');

  /// Set the threshold sensitivity
  ///
  /// The default value is `0.4`
  set thresholdSensitivity(double value) {
    _thresholdSensitivity.value = value;
  }

  /// Set the smoothing
  ///
  /// The default value is `0.1`
  set smoothing(double value) {
    _smoothing.value = value;
  }

  /// Set the color to replace
  ///
  /// The default value is `Color.fromRGBO(0, 255, 0, 1.0)`
  set colorToReplace(Color value) {
    _colorToReplace.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _thresholdSensitivity,
    _smoothing,
    _colorToReplace,
    _image2,
  ];
}
