part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Saturation filter
class GPUSaturationConfiguration extends GPUFilterConfiguration {
  final NumberParameter _saturation;

  GPUSaturationConfiguration()
    : _saturation = GLFloatParameter('inputSaturation', 'Saturation', 1),
      super('Saturation');

  /// Saturation value
  ///
  /// The default value is 1.0
  set saturation(double value) {
    _saturation.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_saturation];
}
