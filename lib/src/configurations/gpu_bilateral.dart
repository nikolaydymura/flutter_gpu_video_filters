part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Bilateral filter
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
      _blurSize = GLFloatParameter('inputBlurSize', 'BlurSize', 1.0),
      super('Bilateral');

  /// Set the texel width offset
  ///
  /// The default value is `0.004`
  set texelWidthOffset(double value) {
    _texelWidthOffset.value = value;
  }

  /// Set the texel height offset
  ///
  /// The default value is `0.004`
  set texelHeightOffset(double value) {
    _texelHeightOffset.value = value;
  }

  /// Set the blur size
  ///
  /// The default value is `1.0`
  set blurSize(double value) {
    _blurSize.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _texelWidthOffset,
    _texelHeightOffset,
    _blurSize,
  ];
}
