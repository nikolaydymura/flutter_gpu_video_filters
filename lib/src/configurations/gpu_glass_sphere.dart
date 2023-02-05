part of flutter_gpu_video_filters;

class GPUGlassSphereConfiguration extends GPUFilterConfiguration {
  final NumberParameter _radius;
  final AspectRatioParameter _aspectRatio;
  final NumberParameter _refractiveIndex;
  final PointParameter _center;

  GPUGlassSphereConfiguration()
      : _radius = _FloatParameter('inputRadius', 'Radius', 0.25),
        _aspectRatio = _AspectRatioParameter(
          'inputAspectRatio',
          'Aspect Ratio',
          const Size(1.0, 1.0),
        ),
        _refractiveIndex =
            _FloatParameter('inputRefractiveIndex', 'Refractive Index', 0.71),
        _center =
            _PointParameter('inputCenter', 'Center', const Point(0.5, 0.5)),
        super('GlassSphere');

  set radius(double value) {
    _radius.value = value;
  }

  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  set center(Point<double> value) {
    _center.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_radius, _aspectRatio, _refractiveIndex, _center];
}
