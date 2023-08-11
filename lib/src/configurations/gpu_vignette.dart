part of flutter_gpu_video_filters;

/// Describes vignette manipulations
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

  /// Updates the [center] value.
  set center(Point<double> value) {
    _center.value = value;
  }

  /// Updates the [color] value.
  set color(Color value) {
    _color.value = value;
  }

  /// Updates the [vignetteStart] value.
  set vignetteStart(double value) {
    _vignetteStart.value = value;
  }

  /// Updates the [vignetteEnd] value.
  set vignetteEnd(double value) {
    _vignetteEnd.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_center, _color, _vignetteStart, _vignetteEnd];
}
