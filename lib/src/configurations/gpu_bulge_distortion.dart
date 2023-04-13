part of flutter_gpu_video_filters;

/// Describes bulge distortion manipulations
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

  /// Updates the [center] value.
  set center(Point<double> value) {
    _center.value = value;
  }

  /// Updates the [aspectRatio] value.
  set aspectRatio(Size value) {
    _aspectRatio.value = value;
  }

  /// Updates the [radius] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set radius(double value) {
    _radius.value = value;
  }

  /// Updates the [scale] value.
  ///
  /// The [value] must be in -1.0 and 1.0 range.
  set scale(double value) {
    _scale.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_center, _aspectRatio, _radius, _scale];
}
