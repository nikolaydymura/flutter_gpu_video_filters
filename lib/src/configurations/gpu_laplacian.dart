part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Laplacian filter
class GPULaplacianConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  final Mat3Parameter _convolutionKernel;

  GPULaplacianConfiguration()
      : _convolutionKernel = GLMat3Parameter(
          'inputConvolutionMatrix',
          'Convolution Matrix',
          Matrix3.fromList([0.5, 1.0, 0.5, 1.0, -6.0, 1.0, 0.5, 1.0, 0.5]),
        ),
        super('Laplacian');

  /// Convolution kernel for the filter
  set convolutionKernel(Matrix3 value) {
    _convolutionKernel.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _convolutionKernel];
}
