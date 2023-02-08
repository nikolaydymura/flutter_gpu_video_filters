part of flutter_gpu_video_filters;

class GPUEmbossConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final VectorParameter _convolutionMatrix;
  final _SliderComputeFloatParameter _intensity;

  GPUEmbossConfiguration()
      : _convolutionMatrix = _Mat3Parameter(
          'inputConvolutionMatrix',
          'Convolution Matrix',
          [
            1.0 * (-2.0),
            -1.0,
            0.0,
            -1.0,
            1.0,
            1.0,
            0.0,
            1.0,
            1.0 * 2.0,
          ],
          hidden: true,
        ),
        _intensity = _SliderComputeFloatParameter(
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

  set intensity(double value) {
    _intensity.value = value;
  }

  void _updateMatrix() {
    final value = _intensity.value.toDouble();
    _convolutionMatrix.value = [
      value * (-2.0),
      -value,
      0.0,
      -value,
      1.0,
      value,
      0.0,
      value,
      value * 2.0
    ];
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _convolutionMatrix, _intensity];
}
