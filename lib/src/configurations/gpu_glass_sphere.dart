part of flutter_gpu_video_filters;

/// Describes glass sphere manipulations
class GPUGlassSphereConfiguration extends GPUFilterConfiguration {
  final NumberParameter _radius;
  final AspectRatioParameter _aspectRatio;
  final NumberParameter _refractiveIndex;
  final PointParameter _center;

  GPUGlassSphereConfiguration()
      : _radius = GLFloatParameter('inputRadius', 'Radius', 0.25),
        _aspectRatio = GLAspectRatioParameter(
          'inputAspectRatio',
          'Aspect Ratio',
          const Size(1.0, 1.0),
        ),
        _refractiveIndex =
            GLFloatParameter('inputRefractiveIndex', 'Refractive Index', 0.71),
        _center =
            GLPointParameter('inputCenter', 'Center', const Point(0.5, 0.5)),
        super('GlassSphere');

  /// Updates the [radius] value.
  set radius(double value) {
    _radius.value = value;
  }

  /// Updates the [aspectRatio] value.
  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  /// Updates the [refractiveIndex] value.
  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  /// Updates the [center] value.
  set center(Point<double> value) {
    _center.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_radius, _aspectRatio, _refractiveIndex, _center];
}
