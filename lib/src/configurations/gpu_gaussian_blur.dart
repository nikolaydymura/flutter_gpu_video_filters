part of flutter_gpu_video_filters;

class GPUGaussianBlurConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUGaussianBlurConfiguration()
      : _texelWidthOffset = GLSliderFloatParameter(
          'inputTexelWidthOffset',
          'TexelWidthOffset',
          0.01,
        ),
        _texelHeightOffset = GLSliderFloatParameter(
          'inputHeightOffset',
          'TexelHeightOffset',
          0.01,
        ),
        _blurSize = GLSliderFloatParameter(
          'inputBlurSize',
          'BlurSize',
          0.2,
        ),
        super('GaussianBlur');

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
