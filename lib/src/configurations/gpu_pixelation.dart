part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Pixelation filter
class GPUPixelationConfiguration extends GPUFilterConfiguration {
  final NumberParameter _pixel;
  final NumberParameter _imageWidthFactor;
  final NumberParameter _imageHeightFactor;

  GPUPixelationConfiguration()
    : _pixel = GLFloatParameter('inputPixel', 'Pixel', 1),
      _imageWidthFactor = GLFloatParameter(
        'inputImageWidthFactor',
        'ImageWidthFactor',
        1 / 720,
      ),
      _imageHeightFactor = GLFloatParameter(
        'inputImageHeightFactor',
        'ImageHeightFactor',
        1 / 720,
      ),
      super('Pixelation');

  /// Pixelation factor
  ///
  /// The default value is 1.0
  set pixel(double value) {
    _pixel.value = value;
  }

  /// Image width factor
  ///
  /// The default value is 1/720
  set imageWidthFactor(double value) {
    _imageWidthFactor.value = value;
  }

  /// Image height factor
  ///
  /// The default value is 1/720
  set imageHeightFactor(double value) {
    _imageHeightFactor.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [
    _pixel,
    _imageWidthFactor,
    _imageHeightFactor,
  ];
}
