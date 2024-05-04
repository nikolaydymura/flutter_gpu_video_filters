part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Swirl filter
class GPUSwirlConfiguration extends GPUFilterConfiguration {
  final NumberParameter _angle;
  final NumberParameter _radius;
  final PointParameter _center;

  GPUSwirlConfiguration()
      : _angle = GLFloatParameter(
          'inputAngle',
          'Angle',
          1.0,
        ),
        _radius = GLSliderFloatParameter(
          'inputRadius',
          'Radius',
          0.5,
          min: 0.0,
          max: 1.0,
        ),
        _center = GLPointParameter(
          'inputCenter',
          'Center',
          const Point(0.5, 0.5),
        ),
        super('Swirl');

  /// Angle value
  ///
  /// The default value is 1.0
  set angle(double value) {
    _angle.value = value;
  }

  /// Radius value
  ///
  /// The default value is 0.5
  set radius(double value) {
    _radius.value = value;
  }

  /// Center of the swirl
  ///
  /// The default value is `Point(0.5, 0.5)`
  set center(Point<double> value) {
    _center.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_angle, _radius, _center];
}
