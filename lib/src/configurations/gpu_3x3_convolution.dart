part of flutter_gpu_video_filters;

class GPU3x3ConvolutionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final VectorParameter _convolutionMatrix;

  GPU3x3ConvolutionConfiguration()
      : _convolutionMatrix = _Mat3Parameter(
          'inputConvolutionMatrix',
          'Convolution Matrix',
          [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0],
        ),
        super('3x3Convolution');

  set convolutionMatrix(List<double> value) {
    assert(value.length == 9);
    _convolutionMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _convolutionMatrix];
}
