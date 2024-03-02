part of '../../flutter_gpu_video_filters.dart';

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
