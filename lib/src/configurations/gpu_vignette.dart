part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Vignette filter
class GPUVignetteConfiguration extends GPUFilterConfiguration {
  final PointParameter _center;
  final ColorParameter _color;
  final NumberParameter _vignetteStart;
  final NumberParameter _vignetteEnd;

  GPUVignetteConfiguration()
      : _center = GLPointParameter(
          'inputVignetteCenter',
          'Vignette Center',
          const Point(0.0, 0.0),
        ),
        _color = GLColorParameter(
          'inputVignetteColor',
          'Vignette Color',
          const Color.fromRGBO(0, 0, 0, 1.0),
        ),
        _vignetteStart = GLFloatParameter(
          'inputVignetteStart',
          'Vignette Start',
          0.3,
        ),
        _vignetteEnd = GLFloatParameter(
          'inputVignetteEnd',
          'Vignette End',
          0.75,
        ),
        super('Vignette');

  /// Center of the vignette
  ///
  /// The default value is `Point(0.0, 0.0)`
  set center(Point<double> value) {
    _center.value = value;
  }

  /// Color of the vignette
  ///
  /// The default value is `Color.fromRGBO(0, 0, 0, 1.0)`
  set color(Color value) {
    _color.value = value;
  }

  /// Start of the vignette
  ///
  /// The default value is 0.3
  set vignetteStart(double value) {
    _vignetteStart.value = value;
  }

  /// End of the vignette
  ///
  /// The default value is 0.75
  set vignetteEnd(double value) {
    _vignetteEnd.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_center, _color, _vignetteStart, _vignetteEnd];
}
