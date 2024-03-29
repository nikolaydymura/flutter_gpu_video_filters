part of '../../flutter_gpu_video_filters.dart';

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

  set intensity(double value) {
    _intensity.value = value;
  }

  set colorMatrix(Matrix4 value) {
    _colorMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _colorMatrix];
}
