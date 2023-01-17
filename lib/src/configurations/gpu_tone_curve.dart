part of flutter_gpu_video_filters;

class GPUToneCurveConfiguration extends GPUFilterConfiguration {
  final PointParameter _redControlPoints;
  final PointParameter _greenControlPoints;
  final PointParameter _blueControlPoints;

  GPUToneCurveConfiguration()
      : _redControlPoints = _PointParameter(
          'inputRedControlPoints',
          'RedControlPoints',
          const Point(0.0, 0.0),
        ),
        _greenControlPoints = _PointParameter(
          'inputGreenControlPoints',
          'GreenControlPoints',
          const Point(0.5, 0.5),
        ),
        _blueControlPoints = _PointParameter(
          'inputGreenControlPoints',
          'GreenControlPoints',
          const Point(1.0, 1.0),
        ),
        super('ToneCurve');

  set redControlPoints(Point<double> value) {
    _redControlPoints.value = value;
  }

  set greenControlPoints(Point<double> value) {
    _greenControlPoints.value = value;
  }
  set blueControlPoints(Point<double> value) {
    _greenControlPoints.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_redControlPoints, _blueControlPoints];
}
