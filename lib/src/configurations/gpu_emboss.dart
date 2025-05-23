part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Emboss filter
class GPUEmbossConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final Mat3Parameter _convolutionMatrix;
  final GLSliderComputeFloatParameter _intensity;

  GPUEmbossConfiguration()
    : _convolutionMatrix = GLMat3Parameter(
        'inputConvolutionMatrix',
        'Convolution Matrix',
        Matrix3.fromList([
          1.0 * (-2.0),
          -1.0,
          0.0,
          -1.0,
          1.0,
          1.0,
          0.0,
          1.0,
          1.0 * 2.0,
        ]),
        hidden: true,
      ),
      _intensity = GLSliderComputeFloatParameter(
        'inputIntensity',
        'Intensity',
        1,
        min: 0,
        max: 4,
      ),
      super('3x3Convolution') {
    _intensity.onChange = () => _updateMatrix();
    _intensity.onUpdate = _convolutionMatrix.update;
  }

  /// The intensity of the filter
  ///
  /// The default value is 1. The value range is from 0 to 4.
  set intensity(double value) {
    _intensity.value = value;
  }

  void _updateMatrix() {
    final value = _intensity.value.toDouble();
    _convolutionMatrix.value = Matrix3.fromList([
      value * (-2.0),
      -value,
      0.0,
      -value,
      1.0,
      value,
      0.0,
      value,
      value * 2.0,
    ]);
  }

  @override
  List<ConfigurationParameter> get parameters => [
    ...super.parameters,
    _convolutionMatrix,
    _intensity,
  ];
}
