part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Exposure filter
class GPUExposureConfiguration extends GPUFilterConfiguration {
  final NumberParameter _exposure;

  GPUExposureConfiguration()
    : _exposure = GLSliderFloatParameter(
        'inputExposure',
        'Exposure',
        0,
        min: -10,
        max: 10,
      ),
      super('Exposure');

  /// The exposure value
  ///
  /// The default value is 0. The value range is from -10 to 10.
  set exposure(double value) {
    _exposure.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_exposure];
}
