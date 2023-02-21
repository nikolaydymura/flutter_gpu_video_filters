part of flutter_gpu_video_filters;

class GPUHalftoneConfiguration extends GPUFilterConfiguration {
  final NumberParameter _fractionalWidthOfPixel;
  final NumberParameter _aspectRatio;

  GPUHalftoneConfiguration()
      : _fractionalWidthOfPixel = GLFloatParameter(
          'inputFractionalWidthOfPixel',
          'FractionalWidthOfPixel',
          0.01,
        ),
        _aspectRatio = GLFloatParameter(
          'inputAspectRatio',
          'AspectRatio',
          1,
        ),
        super('HalfTone');

  set fractionalWidthOfPixel(double value) {
    _fractionalWidthOfPixel.value = value;
  }

  set aspectRatio(double value) {
    _aspectRatio.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_fractionalWidthOfPixel, _aspectRatio];
}
