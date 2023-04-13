part of flutter_gpu_video_filters;

/// Describes box blur manipulations
class GPUBoxBlurConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUBoxBlurConfiguration()
      : _texelWidthOffset = GLFloatParameter(
          'inputTexelWidthOffset',
          'Texel Width Offset',
          0.003,
        ),
        _texelHeightOffset = GLFloatParameter(
          'inputHeightOffset',
          'Texel Height Offset',
          0.003,
        ),
        _blurSize = GLFloatParameter(
          'inputBlurSize',
          'Blur Size',
          1.0,
        ),
        super('BoxBlur');

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
