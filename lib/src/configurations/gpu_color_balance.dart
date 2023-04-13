part of flutter_gpu_video_filters;

/// Describes color balance manipulations
class GPUColorBalanceConfiguration extends GPUFilterConfiguration {
  final Vector3Parameter _shadowsShift;
  final Vector3Parameter _midtonesShift;
  final Vector3Parameter _highlightsShift;
  final BoolParameter _preserveLuminosity;

  GPUColorBalanceConfiguration()
      : _shadowsShift = GLVec3Parameter(
          'inputShadowsShift',
          'Shadows Shift',
          Vector3.zero(),
        ),
        _midtonesShift = GLVec3Parameter(
          'inputMidtonesShift',
          'Midtones Shift',
          Vector3.zero(),
        ),
        _highlightsShift = GLVec3Parameter(
          'inputHighlightsShift',
          'Highlights Shift',
          Vector3.zero(),
        ),
        _preserveLuminosity = GLBoolParameter(
          'inputPreserveLuminosity',
          'Preserve Luminosity',
          true,
        ),
        super('ColorBalance');

  /// Updates the [shadowsShift] value.
  set shadowsShift(Vector3 value) {
    _shadowsShift.value = value;
  }

  /// Updates the [midtonesShift] value.
  set midtonesShift(Vector3 value) {
    _midtonesShift.value = value;
  }

  /// Updates the [highlightsShift] value.
  set highlightsShift(Vector3 value) {
    _highlightsShift.value = value;
  }

  /// Updates the [preserveLuminosity] value.
  set preserveLuminosity(bool value) {
    _preserveLuminosity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_shadowsShift, _midtonesShift, _highlightsShift, _preserveLuminosity];
}
