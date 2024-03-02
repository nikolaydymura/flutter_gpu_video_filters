part of '../../flutter_gpu_video_filters.dart';

class GPUSaturationConfiguration extends GPUFilterConfiguration {
  final NumberParameter _saturation;

  GPUSaturationConfiguration()
      : _saturation = GLFloatParameter(
          'inputSaturation',
          'Saturation',
          1,
        ),
        super('Saturation');

  set saturation(double value) {
    _saturation.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_saturation];
}
