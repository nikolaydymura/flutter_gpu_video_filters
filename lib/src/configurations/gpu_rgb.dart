part of flutter_gpu_video_filters;

class GPURGBConfiguration extends GPUFilterConfiguration {
  final NumberParameter _red;
  final NumberParameter _green;
  final NumberParameter _blue;

  GPURGBConfiguration()
      : _red = _SliderFloatParameter(
          'inputRed',
          'Red',
          1,
          min: 0,
        ),
        _green = _SliderFloatParameter(
          'inputGreen',
          'Green',
          1,
          min: 0,
        ),
        _blue = _SliderFloatParameter(
          'inputBlue',
          'Blue',
          1,
          min: 0,
        ),
        super('RGB');

  set red(double value) {
    _red.value = value;
  }

  set green(double value) {
    _green.value = value;
  }

  set blue(double value) {
    _blue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_red, _green, _blue];
}
