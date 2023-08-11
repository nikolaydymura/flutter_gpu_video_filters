part of flutter_gpu_video_filters;

/// Describes swirl manipulations
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

  /// Updates the [scale] value.
  set scale(double value) {
    _angle.value = value;
  }

  /// Updates the [radius] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set radius(double value) {
    _radius.value = value;
  }

  /// Updates the [center] value.
  set center(Point<double> value) {
    _center.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_angle, _radius, _center];
}
