part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the HighlightShadow filter
class GPUHighlightShadowConfiguration extends GPUFilterConfiguration {
  final NumberParameter _shadows;
  final NumberParameter _highlights;

  GPUHighlightShadowConfiguration()
    : _shadows = GLFloatParameter('inputShadows', 'Shadows', 1),
      _highlights = GLFloatParameter('inputHighlights', 'Highlights', 0.0),
      super('HighlightShadow');

  /// The shadows value
  ///
  /// The default value is 1
  set shadows(double value) {
    _shadows.value = value;
  }

  /// The highlights value
  ///
  /// The default value is 0.0
  set highlights(double value) {
    _highlights.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_shadows, _highlights];
}
