part of flutter_gpu_video_filters;

class GPUMonochromeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final ColorParameter _color;

  GPUMonochromeConfiguration()
      : _intensity = _SliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1,
          min: 0,
          max: 1,
        ),
        _color = _ColorParameter(
          'inputColor',
          'Color',
          const Color.fromRGBO(153, 115, 76, 1.0),
        ),
        super('Monochrome');

  set intensity(double value) {
    _intensity.value = value;
  }

  set color(Color value) {
    _color.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _color];
}
