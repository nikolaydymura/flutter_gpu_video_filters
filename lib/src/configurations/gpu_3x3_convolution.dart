part of '../../flutter_gpu_video_filters.dart';

/// Configuration for 3x3 convolution filters
class GPU3x3ConvolutionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final Mat3Parameter _convolutionMatrix;

  GPU3x3ConvolutionConfiguration()
    : _convolutionMatrix = GLMat3Parameter(
        'inputConvolutionMatrix',
        'Convolution Matrix',
        Matrix3.fromList([0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]),
      ),
      super('3x3Convolution');

  /// Set the convolution matrix
  set convolutionMatrix(Matrix3 value) {
    _convolutionMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    ...super.parameters,
    _convolutionMatrix,
  ];
}
