part of flutter_gpu_video_filters;

class GPUSharpenConfiguration extends GPUFilterConfiguration {
  final NumberParameter _imageWidthFactor;
  final NumberParameter _imageHeightFactor;
  final NumberParameter _sharpness;

  GPUSharpenConfiguration()
      : _imageWidthFactor = _FloatParameter(
          'inputImageWidthFactor',
          'ImageWidthFactor',
          0.004,
        ),
        _imageHeightFactor = _FloatParameter(
          'inputImageHeightFactor',
          'ImageHeightFactor',
          0.004,
        ),
        _sharpness = _FloatParameter(
          'inputSharpness',
          'Sharpness',
          1.0,
        ),
        super('Sharpen');

  set imageWidthFactor(double value) {
    _imageWidthFactor.value = value;
  }

  set imageHeightFactor(double value) {
    _imageHeightFactor.value = value;
  }

  set sharpness(double value) {
    _sharpness.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_imageWidthFactor, _imageHeightFactor, _sharpness];
}
