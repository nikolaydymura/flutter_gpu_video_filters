part of '../../flutter_gpu_video_filters.dart';

class GPUAlphaBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _mixturePercent;

  GPUAlphaBlendConfiguration()
      : _mixturePercent = GLSliderFloatParameter(
          'inputMixturePercent',
          'Mixture Percent',
          0.5,
          min: 0.0,
          max: 1.0,
        ),
        super('AlphaBlend');

  set mixturePercent(double value) {
    _mixturePercent.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_mixturePercent, _image2];
}
