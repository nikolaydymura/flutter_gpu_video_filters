part of flutter_gpu_video_filters;

class GPUEmbossConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final VectorParameter _convolutionMatrix;

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
        super('3x3Convolution');

  set intensity(double value) {
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
      [...super.parameters, _convolutionMatrix];
}
