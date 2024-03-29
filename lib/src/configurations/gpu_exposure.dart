part of '../../flutter_gpu_video_filters.dart';

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

  set exposure(double value) {
    _exposure.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_exposure];
}
