part of '../../flutter_gpu_video_filters.dart';

class GPUPosterizeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _colorLevels;

  GPUPosterizeConfiguration()
      : _colorLevels = GLFloatParameter(
          'inputColorLevels',
          'ColorLevels',
          10,
        ),
        super('Posterize');

  set colorLevels(double value) {
    _colorLevels.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_colorLevels];
}
