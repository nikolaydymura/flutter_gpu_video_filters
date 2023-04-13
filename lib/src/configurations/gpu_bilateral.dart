part of flutter_gpu_video_filters;

/// Describes bilateral manipulations
class GPUBilateralConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUBilateralConfiguration()
      : _texelWidthOffset = GLFloatParameter(
          'inputTexelWidthOffset',
          'TexelWidthOffset',
          0.004,
        ),
        _texelHeightOffset = GLFloatParameter(
          'inputTexelHeightOffset',
          'TexelHeightOffset',
          0.004,
        ),
        _blurSize = GLFloatParameter(
          'inputBlurSize',
          'BlurSize',
          1.0,
        ),
        super('Bilateral');

  /// Updates the [texelWidthOffset] value.
  set texelWidthOffset(double value) {
    _texelWidthOffset.value = value;
  }

  /// Updates the [texelHeightOffset] value.
  set texelHeightOffset(double value) {
    _texelHeightOffset.value = value;
  }

  /// Updates the [blurSize] value.
  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_texelWidthOffset, _texelHeightOffset, _blurSize];
}
