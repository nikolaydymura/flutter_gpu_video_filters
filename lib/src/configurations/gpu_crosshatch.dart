part of '../../flutter_gpu_video_filters.dart';

class GPUCrosshatchConfiguration extends GPUFilterConfiguration {
  final NumberParameter _crossHatchSpacing;
  final NumberParameter _lineWidth;

  GPUCrosshatchConfiguration()
      : _crossHatchSpacing = GLFloatParameter(
          'inputCrossHatchSpacing',
          'CrossHatchSpacing',
          0.03,
        ),
        _lineWidth = GLFloatParameter(
          'inputLineWidth',
          'LineWidth',
          0.003,
        ),
        super('Crosshatch');

  set crossHatchSpacing(double value) {
    _crossHatchSpacing.value = value;
  }

  set lineWidth(double value) {
    _lineWidth.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_crossHatchSpacing, _lineWidth];
}
