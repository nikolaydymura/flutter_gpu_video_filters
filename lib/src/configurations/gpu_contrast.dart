part of '../../flutter_gpu_video_filters.dart';

class GPUContrastConfiguration extends GPUFilterConfiguration {
  final NumberParameter _contrast;

  GPUContrastConfiguration()
      : _contrast = GLSliderFloatParameter(
          'inputContrast',
          'Contrast',
          1.2,
          min: 0,
          max: 4,
        ),
        super('Contrast');

  set contrast(double value) {
    _contrast.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_contrast];
}
