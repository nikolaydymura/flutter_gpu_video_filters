part of flutter_gpu_video_filters;

/// Describes chroma key blend manipulations
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
        _smoothing = GLFloatParameter(
          'inputSmoothing',
          'Smoothing',
          0.1,
        ),
        _colorToReplace = GLColorParameter(
          'inputColorToReplace',
          'Color To Replace',
          const Color.fromRGBO(0, 255, 0, 1.0),
        ),
        super('ChromaKeyBlend');

  /// Updates the [thresholdSensitivity] value.
  set thresholdSensitivity(double value) {
    _thresholdSensitivity.value = value;
  }

  /// Updates the [smoothing] value.
  set smoothing(double value) {
    _smoothing.value = value;
  }

  /// Updates the [colorToReplace] value.
  ///
  /// The [value] must be three channels each in the range 0.0 to 255.0.
  set colorToReplace(Color value) {
    _colorToReplace.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_thresholdSensitivity, _smoothing, _colorToReplace, _image2];
}
