part of '../../flutter_gpu_video_filters.dart';

class GPUGammaConfiguration extends GPUFilterConfiguration {
  final NumberParameter _gamma;

  GPUGammaConfiguration()
      : _gamma = GLFloatParameter(
          'inputGamma',
          'Gamma',
          1.2,
        ),
        super('Gamma');

  set gamma(double value) {
    _gamma.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_gamma];
}
