part of flutter_gpu_video_filters;

class GPURGBConfiguration extends GPUFilterConfiguration {
  final NumberParameter _red;
  final NumberParameter _green;
  final NumberParameter _blue;

  GPURGBConfiguration()
      : _red = GLColorIntensityParameter(
          'inputRed',
          'Red',
          255,
        ),
        _green = GLColorIntensityParameter(
          'inputGreen',
          'Green',
          255,
        ),
        _blue = GLColorIntensityParameter(
          'inputBlue',
          'Blue',
          255,
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
