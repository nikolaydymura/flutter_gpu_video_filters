part of flutter_gpu_video_filters;

class GPUVignetteConfiguration extends GPUFilterConfiguration {
  final PointParameter _center;
  final ColorParameter _color;
  final NumberParameter _vignetteStart;
  final NumberParameter _vignetteEnd;

  GPUVignetteConfiguration()
      : _center = _PointParameter(
          'inputVignetteCenter',
          'Vignette Center',
          const Point(0.0, 0.0),
        ),
        _color = _ColorParameter(
          'inputVignetteColor',
          'Vignette Color',
          Colors.black,
        ),
        _vignetteStart = _FloatParameter(
          'inputVignetteStart',
          'Vignette Start',
          0.3,
        ),
        _vignetteEnd = _FloatParameter(
          'inputVignetteEnd',
          'Vignette End',
          0.75,
        ),
        super('Vignette');

  set center(Point<double> value) {
    _center.value = value;
  }

  set color(Color value) {
    _color.value = value;
  }

  set vignetteStart(double value) {
    _vignetteStart.value = value;
  }

  set vignetteEnd(double value) {
    _vignetteEnd.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_center, _color, _vignetteStart, _vignetteEnd];
}
