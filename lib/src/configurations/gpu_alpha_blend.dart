part of flutter_gpu_video_filters;

class GPUAlphaBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _mixturePercent;

  GPUAlphaBlendConfiguration()
      : _mixturePercent =
            _FloatParameter('inputMixturePercent', 'Mixture Percent', 0),
        super('AlphaBlend');

  set mixturePercent(double value) {
    _mixturePercent.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_mixturePercent, _image2];
}
