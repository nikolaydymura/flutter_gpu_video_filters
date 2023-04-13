part of flutter_gpu_video_filters;

/// Describes exposure manipulations
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

  /// Updates the [brightness] value.
  ///
  /// The [value] must be in -10.0 and 10.0 range.
  set exposure(double value) {
    _exposure.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_exposure];
}
