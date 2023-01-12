part of flutter_gpu_video_filters;

class GPUHueConfiguration extends GPUFilterConfiguration {
  final NumberParameter _hue;

  GPUHueConfiguration()
      : _hue = _FloatParameter(
          'inputHue',
          'Hue',
          90,
        ),
        super('Hue');

  set hue(double value) {
    _hue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_hue];
}
