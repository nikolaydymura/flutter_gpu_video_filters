part of flutter_gpu_video_filters;

class GPUBrightnessConfiguration extends GPUFilterConfiguration {
  final NumberParameter _brightness;

  GPUBrightnessConfiguration()
      : _brightness = _SliderFloatParameter(
          'inputBrightness',
          'Brightness',
          0,
          min: -1,
          max: 1,
        ),
        super('Brightness');

  set brightness(double value) {
    _brightness.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_brightness];
}
