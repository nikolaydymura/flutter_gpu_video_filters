part of flutter_gpu_video_filters;

/// Describes highlight shadow manipulations
class GPUHighlightShadowConfiguration extends GPUFilterConfiguration {
  final NumberParameter _shadows;
  final NumberParameter _highlights;

  GPUHighlightShadowConfiguration()
      : _shadows = GLFloatParameter(
          'inputShadows',
          'Shadows',
          1,
        ),
        _highlights = GLFloatParameter(
          'inputHighlights',
          'Highlights',
          0.0,
        ),
        super('HighlightShadow');

  /// Updates the [shadows] value.
  set shadows(double value) {
    _shadows.value = value;
  }

  /// Updates the [highlights] value.
  set highlights(double value) {
    _highlights.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_shadows, _highlights];
}
