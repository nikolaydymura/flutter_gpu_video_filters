part of flutter_gpu_video_filters;

class GPUColorMatrixConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final Matrix4Parameter _colorMatrix;

  GPUColorMatrixConfiguration()
      : _intensity = _FloatParameter('inputIntensity', 'Intensity', 1.0),
        _colorMatrix = _Mat4Parameter(
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
