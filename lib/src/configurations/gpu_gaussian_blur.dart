part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the GaussianBlur filter
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

  /// The texel width offset
  ///
  /// The default value is 0.1.
  set texelWidthOffset(double value) {
    _texelWidthOffset.value = value;
  }

  /// The texel height offset
  ///
  /// The default value is 0.01.
  set texelHeightOffset(double value) {
    _texelHeightOffset.value = value;
  }

  /// The blur size
  ///
  /// The default value is 0.2.
  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_texelWidthOffset, _texelHeightOffset, _blurSize];
}
