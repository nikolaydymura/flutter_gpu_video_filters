part of flutter_gpu_video_filters;

class GPUThreex3TextureSamplingConfiguration extends GPUFilterConfiguration {
  final NumberParameter _texelWidth;

  final NumberParameter _texelHeight;

  GPUThreex3TextureSamplingConfiguration()
      : _texelWidth = _FloatParameter(
          'inputTexelWidth',
          'TexelWidth',
          0,
        ),
        _texelHeight = _FloatParameter(
          'inputTexelHeight',
          'TexelHeight',
          0,
        ),
        super('Threex3TextureSampling');

  set texelWidth(double value) {
    _texelWidth.value = value;
  }

  set texelHeight(double value) {
    _texelHeight.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_texelWidth, _texelHeight];
}
