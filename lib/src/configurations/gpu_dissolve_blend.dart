part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the DissolveBlend filter
class GPUDissolveBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _mixturePercent;

  GPUDissolveBlendConfiguration()
    : _mixturePercent = GLSliderFloatParameter(
        'inputMixturePercent',
        'Mixture Percent',
        0.5,
        min: 0.0,
        max: 1.0,
      ),
      super('DissolveBlend');

  /// The percentage of the second image to blend with the first image.
  ///
  /// The default value is 0.5. The value range is from 0 to 1.
  set mixturePercent(double value) {
    _mixturePercent.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_mixturePercent, _image2];
}
