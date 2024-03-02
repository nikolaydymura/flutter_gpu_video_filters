part of '../../flutter_gpu_video_filters.dart';

class GPULuminanceThresholdConfiguration extends GPUFilterConfiguration {
  final NumberParameter _threshold;

  GPULuminanceThresholdConfiguration()
      : _threshold = GLFloatParameter(
          'inputThreshold',
          'Threshold',
          0.5,
        ),
        super('LuminanceThreshold');

  set threshold(double value) {
    _threshold.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_threshold];
}
