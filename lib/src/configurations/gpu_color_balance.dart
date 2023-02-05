part of flutter_gpu_video_filters;

class GPUColorBalanceConfiguration extends GPUFilterConfiguration {
  final VectorParameter _shadowsShift;
  final VectorParameter _midtonesShift;
  final VectorParameter _highlightsShift;
  final BoolParameter _preserveLuminosity;

  GPUColorBalanceConfiguration()
      : _shadowsShift = _Vec3Parameter(
          'inputShadowsShift',
          'Shadows Shift',
          [0.0, 0.0, 0.0],
        ),
        _midtonesShift = _Vec3Parameter(
          'inputMidtonesShift',
          'Midtones Shift',
          [0.0, 0.0, 0.0],
        ),
        _highlightsShift = _Vec3Parameter(
          'inputHighlightsShift',
          'Highlights Shift',
          [0.0, 0.0, 0.0],
        ),
        _preserveLuminosity = _BoolParameter(
          'inputPreserveLuminosity',
          'Preserve Luminosity',
          true,
        ),
        super('ColorBalance');

  set shadowsShift(List<double> value) {
    _shadowsShift.value = value;
  }

  set midtonesShift(List<double> value) {
    _midtonesShift.value = value;
  }

  set highlightsShift(List<double> value) {
    _highlightsShift.value = value;
  }

  set preserveLuminosity(bool value) {
    _preserveLuminosity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_shadowsShift, _midtonesShift, _highlightsShift, _preserveLuminosity];
}
