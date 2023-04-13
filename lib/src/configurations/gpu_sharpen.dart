part of flutter_gpu_video_filters;

/// Describes Sharpen manipulations
class GPUSharpenConfiguration extends GPUFilterConfiguration {
  final NumberParameter _imageWidthFactor;
  final NumberParameter _imageHeightFactor;
  final NumberParameter _sharpness;

  GPUSharpenConfiguration()
      : _imageWidthFactor = GLFloatParameter(
          'inputImageWidthFactor',
          'Image Width Factor',
          0.004,
        ),
        _imageHeightFactor = GLFloatParameter(
          'inputImageHeightFactor',
          'Image Height Factor',
          0.004,
        ),
        _sharpness = GLSliderFloatParameter(
          'inputSharpness',
          'Sharpness',
          0.0,
          min: -4,
          max: 4,
        ),
        super('Sharpen');

  // coverage:ignore-start
  @override
  String get _previewVertex => 'VertexPreviewSharpen';

  @override
  String get _exportVertex => 'VertexSharpen';
  // coverage:ignore-end

  /// Updates the [imageWidthFactor] value.
  set imageWidthFactor(double value) {
    _imageWidthFactor.value = value;
  }

  /// Updates the [imageHeightFactor] value.
  set imageHeightFactor(double value) {
    _imageHeightFactor.value = value;
  }

  /// Updates the [sharpness] value.
  ///
  /// The [value] must be in -4.0 and 4.0 range.
  set sharpness(double value) {
    _sharpness.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_imageWidthFactor, _imageHeightFactor, _sharpness];
}
