part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Haze filter
class GPUHazeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _distance;
  final NumberParameter _slope;

  GPUHazeConfiguration()
    : _distance = GLFloatParameter('inputDistance', 'Distance', 0.2),
      _slope = GLFloatParameter('inputSlope', 'Slope', 0.0),
      super('Haze');

  /// The distance value
  ///
  /// The default value is 0.2
  set distance(double value) {
    _distance.value = value;
  }

  /// The slope value
  ///
  /// The default value is 0.0
  set slope(double value) {
    _slope.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_distance, _slope];
}
