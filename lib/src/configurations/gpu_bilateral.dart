part of flutter_gpu_video_filters;

class GPUBilateralConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUBilateralConfiguration()
      : _texelWidthOffset = _FloatParameter(
          'inputTexelWidthOffset',
          'TexelWidthOffset',
          0.004,
        ),
        _texelHeightOffset = _FloatParameter(
          'inputHeightOffset',
          'TexelHeightOffset',
          0.004,
        ),
        _blurSize = _FloatParameter(
          'inputBlurSize',
          'BlurSize',
          1.0,
        ),
        super('Bilateral');

  set texelWidthOffset(double value) {
    _texelWidthOffset.value = value;
  }

  set texelHeightOffset(double value) {
    _texelHeightOffset.value = value;
  }

  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_texelWidthOffset, _texelHeightOffset, _blurSize];
}
