part of flutter_gpu_video_filters;

/// Describes haze manipulations
class GPUHazeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _distance;
  final NumberParameter _slope;

  GPUHazeConfiguration()
      : _distance = GLFloatParameter(
          'inputDistance',
          'Distance',
          0.2,
        ),
        _slope = GLFloatParameter(
          'inputSlope',
          'Slope',
          0.0,
        ),
        super('Haze');

  /// Updates the [distance] value.
  set distance(double value) {
    _distance.value = value;
  }

  /// Updates the [slope] value.
  set slope(double value) {
    _slope.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_distance, _slope];
}
