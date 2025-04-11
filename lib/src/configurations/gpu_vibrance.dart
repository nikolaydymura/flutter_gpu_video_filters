part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Vibrance filter
class GPUVibranceConfiguration extends GPUFilterConfiguration {
  final NumberParameter _vibrance;

  GPUVibranceConfiguration()
    : _vibrance = GLFloatParameter('inputVibrance', 'Vibrance', 0),
      super('Vibrance');

  /// Vibrance value
  ///
  /// The default value is 0
  set vibrance(double value) {
    _vibrance.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_vibrance];
}
