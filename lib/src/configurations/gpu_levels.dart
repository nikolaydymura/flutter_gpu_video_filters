part of flutter_gpu_video_filters;

class GPULevelsConfiguration extends GPUFilterConfiguration {
  final VectorParameter _levelMinimum;
  final VectorParameter _levelMiddle;
  final VectorParameter _levelMaximum;
  final VectorParameter _minOutput;
  final VectorParameter _maxOutput;

  GPULevelsConfiguration()
      : _levelMinimum = _Vec3Parameter(
          'inputLevelMinimum',
          'Level Minimum',
          [0.0, 0.0, 0.0],
        ),
        _levelMiddle =
            _Vec3Parameter('inputLevelMiddle', 'Level Middle', [1.0, 1.0, 1.0]),
        _levelMaximum = _Vec3Parameter(
          'inputLevelMaximum',
          'Level Maximum',
          [1.0, 1.0, 1.0],
        ),
        _minOutput =
            _Vec3Parameter('inputMinOutput', 'Min Output', [0.0, 0.0, 0.0]),
        _maxOutput =
            _Vec3Parameter('inputMaxOutput', 'Max Output', [1.0, 1.0, 1.0]),
        super('Levels');

  set maxOutput(List<double> value) {
    _maxOutput.value = value;
  }

  set minOutput(List<double> value) {
    _minOutput.value = value;
  }

  set levelMaximum(List<double> value) {
    _levelMaximum.value = value;
  }

  set levelMiddle(List<double> value) {
    _levelMiddle.value = value;
  }

  set levelMinimum(List<double> value) {
    _levelMinimum.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_maxOutput, _minOutput, _levelMaximum, _levelMiddle, _levelMinimum];
}
