part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the ColorBalance filter
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

  /// Set the shadows shift
  ///
  /// The default value is `Vector3.zero()`
  set shadowsShift(Vector3 value) {
    _shadowsShift.value = value;
  }

  /// Set the midtones shift
  ///
  /// The default value is `Vector3.zero()`
  set midtonesShift(Vector3 value) {
    _midtonesShift.value = value;
  }

  /// Set the highlights shift
  ///
  /// The default value is `Vector3.zero()`
  set highlightsShift(Vector3 value) {
    _highlightsShift.value = value;
  }

  /// Set the preserve luminosity
  ///
  /// The default value is `true`
  set preserveLuminosity(bool value) {
    _preserveLuminosity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _shadowsShift,
    _midtonesShift,
    _highlightsShift,
    _preserveLuminosity,
  ];
}
