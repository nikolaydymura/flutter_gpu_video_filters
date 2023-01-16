part of flutter_gpu_video_filters;

class GPUHighlightShadowConfiguration extends GPUFilterConfiguration {
  final NumberParameter _shadows;
  final NumberParameter _highlights;

  GPUHighlightShadowConfiguration()
      : _shadows = _FloatParameter(
          'inputShadows',
          'Shadows',
          1,
        ),
        _highlights = _FloatParameter(
          'inputHighlights',
          'Highlights',
          0.0,
        ),
        super('HighlightShadow');

  set shadows(double value) {
    _shadows.value = value;
  }

  set highlights(double value) {
    _highlights.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_shadows, _highlights];
}
