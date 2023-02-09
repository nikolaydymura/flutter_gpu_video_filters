part of flutter_gpu_video_filters;

class GPU3x3ConvolutionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final Mat3Parameter _convolutionMatrix;

  GPU3x3ConvolutionConfiguration()
      : _convolutionMatrix = _Mat3Parameter(
          'inputConvolutionMatrix',
          'Convolution Matrix',
          Mat3([0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]),
        ),
        super('3x3Convolution');

  set convolutionMatrix(Mat3 value) {
    _convolutionMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _convolutionMatrix];
}
