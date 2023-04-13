part of flutter_gpu_video_filters;

/// Describes alpha blend manipulations
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

  /// Updates the [mixturePercent] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set mixturePercent(double value) {
    _mixturePercent.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_mixturePercent, _image2];
}
