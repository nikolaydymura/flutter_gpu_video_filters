part of flutter_gpu_video_filters;

/// Describes levels manipulations
class GPULevelsConfiguration extends GPUFilterConfiguration {
  final Vector3Parameter _levelMinimum;
  final Vector3Parameter _levelMiddle;
  final Vector3Parameter _levelMaximum;
  final Vector3Parameter _minOutput;
  final Vector3Parameter _maxOutput;

  GPULevelsConfiguration()
      : _levelMinimum = GLVec3Parameter(
          'inputLevelMinimum',
          'Level Minimum',
          Vector3(0.0, 0.0, 0.0),
        ),
        _levelMiddle = GLVec3Parameter(
          'inputLevelMiddle',
          'Level Middle',
          Vector3(1.0, 1.0, 1.0),
        ),
        _levelMaximum = GLVec3Parameter(
          'inputLevelMaximum',
          'Level Maximum',
          Vector3(1.0, 1.0, 1.0),
        ),
        _minOutput = GLVec3Parameter(
          'inputMinOutput',
          'Min Output',
          Vector3(0.0, 0.0, 0.0),
        ),
        _maxOutput = GLVec3Parameter(
          'inputMaxOutput',
          'Max Output',
          Vector3(1.0, 1.0, 1.0),
        ),
        super('Levels');

  /// Updates the [maxOutput] value.
  set maxOutput(Vector3 value) {
    _maxOutput.value = value;
  }

  /// Updates the [minOutput] value.
  set minOutput(Vector3 value) {
    _minOutput.value = value;
  }

  /// Updates the [levelMaximum] value.
  set levelMaximum(Vector3 value) {
    _levelMaximum.value = value;
  }

  /// Updates the [levelMiddle] value.
  set levelMiddle(Vector3 value) {
    _levelMiddle.value = value;
  }

  /// Updates the [levelMinimum] value.
  set levelMinimum(Vector3 value) {
    _levelMinimum.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_maxOutput, _minOutput, _levelMaximum, _levelMiddle, _levelMinimum];
}
