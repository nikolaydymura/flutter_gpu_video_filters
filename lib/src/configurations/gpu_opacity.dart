part of flutter_gpu_video_filters;

class GPUOpacityConfiguration extends GPUFilterConfiguration {
  final NumberParameter _opacity;

  GPUOpacityConfiguration()
      : _opacity = GLSliderFloatParameter(
          'inputOpacity',
          'Opacity',
          1,
          min: 0,
          max: 1,
        ),
        super('Opacity');

  set opacity(double value) {
    _opacity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_opacity];
}
