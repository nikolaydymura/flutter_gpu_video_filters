part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Halftone filter
class GPUHalftoneConfiguration extends GPUFilterConfiguration {
  final NumberParameter _fractionalWidthOfPixel;
  final NumberParameter _aspectRatio;

  GPUHalftoneConfiguration()
    : _fractionalWidthOfPixel = GLFloatParameter(
        'inputFractionalWidthOfPixel',
        'FractionalWidthOfPixel',
        0.01,
      ),
      _aspectRatio = GLFloatParameter('inputAspectRatio', 'AspectRatio', 1),
      super('HalfTone');

  /// The fractional width of a pixel
  ///
  /// The default value is 0.01.
  set fractionalWidthOfPixel(double value) {
    _fractionalWidthOfPixel.value = value;
  }

  /// The aspect ratio of the halftone pattern
  ///
  /// The default value is 1.
  set aspectRatio(double value) {
    _aspectRatio.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _fractionalWidthOfPixel,
    _aspectRatio,
  ];
}
