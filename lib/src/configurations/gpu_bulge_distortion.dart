part of flutter_gpu_video_filters;

class GPUBulgeDistortionConfiguration extends GPUFilterConfiguration {
  final NumberParameter _centerX;
  final NumberParameter _centerY;
  final NumberParameter _radius;
  final NumberParameter _scale;

  GPUBulgeDistortionConfiguration()
      : _centerX = _FloatParameter(
          'inputCenterX',
          'CenterX',
          0.5,
        ),
        _centerY = _FloatParameter(
          'inputCenterY',
          'CenterY',
          0.5,
        ),
        _radius = _FloatParameter(
          'inputRadius',
          'Radius',
          0.25,
        ),
        _scale = _FloatParameter(
          'inputScale',
          'Scale',
          0.5,
        ),
        super('BulgeDistortion');

  set centerX(double value) {
    _centerX.value = value;
  }

  set centerY(double value) {
    _centerY.value = value;
  }
  set radius(double value) {
    _radius.value = value;
  }

  set scale(double value) {
    _scale.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_centerX, _centerY, _radius, _scale];
}
