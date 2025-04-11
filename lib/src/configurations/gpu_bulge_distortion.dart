part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the BulgeDistortion filter
class GPUBulgeDistortionConfiguration extends GPUFilterConfiguration {
  final PointParameter _center;
  final AspectRatioParameter _aspectRatio;
  final NumberParameter _radius;
  final NumberParameter _scale;

  GPUBulgeDistortionConfiguration()
    : _center = GLPointParameter(
        'inputCenter',
        'Center',
        const Point(0.5, 0.5),
      ),
      _aspectRatio = GLAspectRatioParameter(
        'inputAspectRatio',
        'Aspect Ratio',
        const Size(1.0, 1.0),
      ),
      _radius = GLSliderFloatParameter(
        'inputRadius',
        'Radius',
        0.25,
        min: 0.0,
        max: 1.0,
      ),
      _scale = GLSliderFloatParameter(
        'inputScale',
        'Scale',
        0.5,
        min: -1.0,
        max: 1.0,
      ),
      super('BulgeDistortion');

  /// Set the center
  ///
  /// The default value is `Point(0.5, 0.5)`
  set center(Point<double> value) {
    _center.value = value;
  }

  /// Set the aspect ratio
  ///
  /// The default value is `Size(1.0, 1.0)`
  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  /// Set the radius
  ///
  /// The default value is `0.25`
  set radius(double value) {
    _radius.value = value;
  }

  /// Set the scale
  ///
  /// The default value is `0.5`
  set scale(double value) {
    _scale.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _center,
    _aspectRatio,
    _radius,
    _scale,
  ];
}
