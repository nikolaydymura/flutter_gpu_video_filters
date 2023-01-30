part of flutter_gpu_video_filters;

class GPUVignetteConfiguration extends GPUFilterConfiguration {
  final NumberParameter _centerX;
  final NumberParameter _centerY;
  final NumberParameter _vignetteStart;
  final NumberParameter _vignetteEnd;

  GPUVignetteConfiguration()
      : _centerX = _FloatParameter(
          'inputCenterX',
          'CenterX',
          0.5,
        ),
        _centerY = _FloatParameter(
          'inputCenterY',
          'CenterY',
          0.5,
        ),
        _vignetteStart = _FloatParameter(
          'inputVignetteStart',
          'Start',
          0.2,
        ),
        _vignetteEnd = _FloatParameter(
          'inputVignetteEnd',
          'VignetteEnd',
          0.85,
        ),
        super('Vignette');

  set centerX(double value) {
    _centerX.value = value;
  }

  set centerY(double value) {
    _centerY.value = value;
  }

  set vignetteStart(double value) {
    _vignetteStart.value = value;
  }

  set vignetteEnd(double value) {
    _vignetteEnd.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_centerX, _centerY, _vignetteStart, _vignetteEnd];
}
