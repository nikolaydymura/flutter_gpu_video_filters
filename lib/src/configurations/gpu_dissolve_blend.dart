part of flutter_gpu_video_filters;

class GPUDissolveBlendConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _mixturePercent;

  GPUDissolveBlendConfiguration()
      : _mixturePercent =
            _FloatParameter('inputMixturePercent', 'Mixture Percent', 0),
        super('DissolveBlend');

  set mixturePercent(double value) {
    _mixturePercent.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_mixturePercent, _image2];
}
