part of flutter_gpu_video_filters;

class GPUHueConfiguration extends GPUFilterConfiguration {
  final NumberParameter _hue;

  GPUHueConfiguration()
      : _hue = _FloatParameter(
          'inputHueAdjust',
          'Hue Adjust',
          1.57,
        ),
        super('Hue');

  set hue(double value) {
    _hue.value = (value % 360.0) * pi / 180.0;
  }

  @override
  List<ConfigurationParameter> get parameters => [_hue];
}
