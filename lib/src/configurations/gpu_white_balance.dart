part of flutter_gpu_video_filters;

class GPUWhiteBalanceConfiguration extends GPUFilterConfiguration {
  final NumberParameter _temperature;
  final NumberParameter _tint;

  GPUWhiteBalanceConfiguration()
      : _temperature = _FloatParameter(
          'inputTemperature',
          'Temperature',
          5000,
        ),
        _tint = _FloatParameter(
          'inputTint',
          'Tint',
          0,
        ),
        super('WhiteBalance');

  set temperature(double value) {
    _temperature.value = value;
  }

  set tint(double value) {
    _tint.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_temperature, _tint];
}
