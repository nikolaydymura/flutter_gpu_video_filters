part of flutter_gpu_video_filters;

/// Describes saturation manipulations
class GPUSaturationConfiguration extends GPUFilterConfiguration {
  final NumberParameter _saturation;

  GPUSaturationConfiguration()
      : _saturation = GLFloatParameter(
          'inputSaturation',
          'Saturation',
          1,
        ),
        super('Saturation');

  /// Updates the [saturation] value.
  set saturation(double value) {
    _saturation.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_saturation];
}
