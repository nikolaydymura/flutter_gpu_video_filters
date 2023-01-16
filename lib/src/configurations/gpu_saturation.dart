part of flutter_gpu_video_filters;

class GPUSaturationConfiguration extends GPUFilterConfiguration {
  final NumberParameter _saturation;

  GPUSaturationConfiguration()
      : _saturation = _FloatParameter(
          'inputSaturation',
          'Saturation',
          1,
        ),
        super('Saturation');

  set saturation(double value) {
    _saturation.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_saturation];
}
