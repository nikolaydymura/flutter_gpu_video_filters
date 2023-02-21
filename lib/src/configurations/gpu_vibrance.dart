part of flutter_gpu_video_filters;

class GPUVibranceConfiguration extends GPUFilterConfiguration {
  final NumberParameter _vibrance;

  GPUVibranceConfiguration()
      : _vibrance = GLFloatParameter(
          'inputVibrance',
          'Vibrance',
          0,
        ),
        super('Vibrance');

  set vibrance(double value) {
    _vibrance.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_vibrance];
}
