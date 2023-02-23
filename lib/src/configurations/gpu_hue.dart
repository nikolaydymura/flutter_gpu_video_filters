part of flutter_gpu_video_filters;

class GPUHueConfiguration extends GPUFilterConfiguration {
  final NumberParameter _hue;

  GPUHueConfiguration()
      : _hue = GLHueParameter(
          'inputHueAdjust',
          'Hue Adjust',
          90.0,
        ),
        super('Hue');

  set hue(double value) {
    _hue.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_hue];
}
