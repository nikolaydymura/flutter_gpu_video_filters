part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the GlassSphere filter
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

  /// The radius of the sphere.
  ///
  /// The default value is 0.25.
  set radius(double value) {
    _radius.value = value;
  }

  /// The aspect ratio of the sphere.
  ///
  /// The default value is Size(1.0, 1.0).
  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  /// The refractive index of the sphere.
  ///
  /// The default value is 0.71.
  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  /// The center of the sphere.
  ///
  /// The default value is Point(0.5, 0.5).
  set center(Point<double> value) {
    _center.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_radius, _aspectRatio, _refractiveIndex, _center];
}
