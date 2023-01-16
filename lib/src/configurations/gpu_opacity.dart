part of flutter_gpu_video_filters;

class GPUOpacityConfiguration extends GPUFilterConfiguration {
  final NumberParameter _opacity;

  GPUOpacityConfiguration()
      : _opacity = _SliderFloatParameter(
          'inputOpacity',
          'Opacity',
          0,
          min: -1,
          max: 1,
        ),
        super('Opacity');

  set opacity(double value) {
    _opacity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_opacity];
}
