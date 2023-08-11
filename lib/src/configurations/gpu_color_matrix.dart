part of flutter_gpu_video_filters;

///Describes color changes using the values of a 4x4 matrix
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

  /// Updates the [intensity] value.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Updates the [colorMatrix] value.
  set colorMatrix(Matrix4 value) {
    _colorMatrix.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _colorMatrix];
}
