part of flutter_gpu_video_filters;

/// Describes posterize manipulations
class GPUPosterizeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _colorLevels;

  GPUPosterizeConfiguration()
      : _colorLevels = GLFloatParameter(
          'inputColorLevels',
          'ColorLevels',
          10,
        ),
        super('Posterize');

  /// Updates the [colorLevels] value.
  set colorLevels(double value) {
    _colorLevels.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_colorLevels];
}
