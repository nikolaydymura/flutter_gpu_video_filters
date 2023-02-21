part of flutter_gpu_video_filters;

class GPUBoxBlurConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUBoxBlurConfiguration()
      : _texelWidthOffset = GLFloatParameter(
          'inputTexelWidthOffset',
          'TexelWidthOffset',
          0.003,
        ),
        _texelHeightOffset = GLFloatParameter(
          'inputHeightOffset',
          'TexelHeightOffset',
          0.003,
        ),
        _blurSize = GLFloatParameter(
          'inputBlurSize',
          'BlurSize',
          1.0,
        ),
        super('BoxBlur');

  set intensity(double value) {
    _texelWidthOffset.value = value;
  }

  set texelHeightOffset(double value) {
    _texelWidthOffset.value = value;
  }

  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_texelWidthOffset, _texelHeightOffset, _blurSize];
}
