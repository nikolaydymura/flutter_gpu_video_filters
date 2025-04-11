part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the SphereRefraction filter
class GPUSphereRefractionConfiguration extends GPUFilterConfiguration {
  final PointParameter _center;
  final NumberParameter _radius;
  final AspectRatioParameter _aspectRatio;
  final NumberParameter _refractiveIndex;

  GPUSphereRefractionConfiguration()
    : _center = GLPointParameter(
        'inputCenter',
        'Center',
        const Point(0.5, 0.5),
      ),
      _radius = GLSliderFloatParameter(
        'inputRadius',
        'Radius',
        0.25,
        min: 0.0,
        max: 1.0,
      ),
      _aspectRatio = GLAspectRatioParameter(
        'inputAspectRatio',
        'Aspect Ratio',
        const Size.square(1),
      ),
      _refractiveIndex = GLFloatParameter(
        'inputRefractiveIndex',
        'Refractive Index',
        0.71,
      ),
      super('SphereRefraction');

  /// Center of the sphere
  ///
  /// The default value is `Point(0.5, 0.5)`
  set centerX(Point<double> value) {
    _center.value = value;
  }

  /// Radius of the sphere
  ///
  /// The default value is 0.25
  set radius(double value) {
    _radius.value = value;
  }

  /// Aspect ratio of the sphere
  ///
  /// The default value is `Size.square(1)`
  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  /// Refractive index of the sphere
  ///
  /// The default value is 0.71
  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _center,
    _radius,
    _aspectRatio,
    _refractiveIndex,
  ];
}
