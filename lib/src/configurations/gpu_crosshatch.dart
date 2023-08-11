part of flutter_gpu_video_filters;

/// Describes crosshatch manipulations
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

  /// Updates the [crossHatchSpacing] value.
  set crossHatchSpacing(double value) {
    _crossHatchSpacing.value = value;
  }

  /// Updates the [lineWidth] value.
  set lineWidth(double value) {
    _lineWidth.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_crossHatchSpacing, _lineWidth];
}
