part of flutter_gpu_video_filters;

class GPUFalseColorConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _intensity;

  GPUFalseColorConfiguration()
      : _intensity = _FloatParameter('inputIntensity', 'Intensity', 0),
        super('FalseColor');

  set intensity(double value) {
    _intensity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _image2];
}
