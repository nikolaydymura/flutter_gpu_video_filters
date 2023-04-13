part of flutter_gpu_video_filters;

/// Describes zoom blur manipulations
class GPUZoomBlurConfiguration extends GPUFilterConfiguration {
  final PointParameter _center;
  final NumberParameter _blurSize;

  GPUZoomBlurConfiguration()
      : _center = GLPointParameter(
          'inputBlurCenter',
          'Center',
          const Point(0.5, 0.5),
        ),
        _blurSize = GLFloatParameter(
          'inputBlurSize',
          'Blur Size',
          1.0,
        ),
        super('ZoomBlur');

  /// Updates the [center] value.
  set center(Point<double> value) {
    _center.value = value;
  }

  /// Updates the [blurSize] value.
  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_center, _blurSize];
}
