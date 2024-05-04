part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Monochrome filter
class GPUMonochromeConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final ColorParameter _color;

  GPUMonochromeConfiguration()
      : _intensity = GLSliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1,
          min: 0,
          max: 1,
        ),
        _color = GLColorParameter(
          'inputColor',
          'Color',
          const Color.fromRGBO(153, 115, 76, 1.0),
        ),
        super('Monochrome');

  /// Set the intensity of the filter
  ///
  /// The intensity of the filter. A value of 0.0 will have no effect on the image, while a value of 1.0 will apply the full effect.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Set the color of the filter
  ///
  /// The color to use for the monochrome effect.
  set color(Color value) {
    _color.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _color];
}
