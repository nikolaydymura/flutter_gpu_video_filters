part of flutter_gpu_video_filters;

/// Describes gamma manipulations
class GPUGammaConfiguration extends GPUFilterConfiguration {
  final NumberParameter _gamma;

  GPUGammaConfiguration()
      : _gamma = GLFloatParameter(
          'inputGamma',
          'Gamma',
          1.2,
        ),
        super('Gamma');

  /// Updates the [gamma] value.
  set gamma(double value) {
    _gamma.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_gamma];
}
