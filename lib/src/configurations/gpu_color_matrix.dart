part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the ColorMatrix filter
class GPUColorMatrixConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final Mat4Parameter _colorMatrix;

  GPUColorMatrixConfiguration()
    : _intensity = GLFloatParameter('inputIntensity', 'Intensity', 1.0),
      _colorMatrix = GLMat4Parameter(
        'inputColorMatrix',
        'Color Matrix',
        Matrix4.identity(),
      ),
      super('ColorMatrix');

  /// Intensity of the filter
  ///
  /// Default value is 1.0
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Color matrix of the filter
  ///
  /// Default value is `Matrix4.identity()`
  set colorMatrix(Matrix4 value) {
    _colorMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _colorMatrix];
}
