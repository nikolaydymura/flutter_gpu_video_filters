part of flutter_gpu_video_filters;

/// Describes vibrance manipulations
class GPUVibranceConfiguration extends GPUFilterConfiguration {
  final NumberParameter _vibrance;

  GPUVibranceConfiguration()
      : _vibrance = GLFloatParameter(
          'inputVibrance',
          'Vibrance',
          0,
        ),
        super('Vibrance');

  /// Updates the [vibrance] value.
  set vibrance(double value) {
    _vibrance.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_vibrance];
}
