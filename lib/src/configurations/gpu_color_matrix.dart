part of flutter_gpu_video_filters;

class GPUColorMatrixConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _intensity;

  GPUColorMatrixConfiguration()
      : _intensity = _FloatParameter('inputIntensity', 'Color Matrix', 0),
        super('ColorMatrix');

  set intensity(double value) {
    _intensity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _image2];
}
