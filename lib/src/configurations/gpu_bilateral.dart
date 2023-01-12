part of flutter_gpu_video_filters;

class GPUBilateralConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidthOffset;
  final NumberParameter _texelHeightOffset;
  final NumberParameter _blurSize;

  GPUBilateralConfiguration()
      : _texelWidthOffset = _SliderFloatParameter(
          'inputTexelWidthOffset',
          'TexelWidthOffset',
          0.004,
        ),
        _texelHeightOffset = _SliderFloatParameter(
          'inputHeightOffset',
          'TexelHeightOffset',
          0.004,
        ),
        _blurSize = _SliderFloatParameter(
          'inputBlurSize',
          'BlurSize',
          1.0,
        ),
        super('Bilateral');

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
