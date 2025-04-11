part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Contrast filter
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

  /// The contrast value.
  ///
  /// The default value is 1.2. The value range is from 0 to 4.
  set contrast(double value) {
    _contrast.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_contrast];
}
