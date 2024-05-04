part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Posterize filter
class GPUPosterizeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _colorLevels;

  GPUPosterizeConfiguration()
      : _colorLevels = GLFloatParameter(
          'inputColorLevels',
          'ColorLevels',
          10,
        ),
        super('Posterize');

  /// The number of color levels to use
  ///
  /// The default value is 10.0
  set colorLevels(double value) {
    _colorLevels.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_colorLevels];
}
