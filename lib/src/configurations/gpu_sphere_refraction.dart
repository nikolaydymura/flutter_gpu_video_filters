part of flutter_gpu_video_filters;

class GPUSphereRefractionConfiguration extends GPUFilterConfiguration {
  final NumberParameter _centerX;
  final NumberParameter _centerY;
  final NumberParameter _radius;
  final NumberParameter _aspectRatio;
  final NumberParameter _refractiveIndex;

  GPUSphereRefractionConfiguration()
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
          0.5,
        ),
        _aspectRatio = _FloatParameter(
          'inputAspectRatio',
          'AspectRatio',
          1.0,
        ),
        _refractiveIndex = _FloatParameter(
          'inputRefractiveIndex',
          'RefractiveIndex',
          0.71,
        ),
        super('SphereRefraction');

  set centerX(double value) {
    _centerX.value = value;
  }

  set centerY(double value) {
    _centerY.value = value;
  }
  set radius(double value) {
    _radius.value = value;
  }

  set aspectRatio(double value) {
    _aspectRatio.value = value;
  }

  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_centerX, _centerY, _radius, _aspectRatio, _refractiveIndex];
}
