part of flutter_gpu_video_filters;

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

  set intensity(double value) {
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
