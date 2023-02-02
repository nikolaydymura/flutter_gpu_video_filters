part of flutter_gpu_video_filters;

mixin Sampling3x3Mixin on GPUFilterConfiguration {
  final NumberParameter _texelWidth = _FloatParameter(
    'inputTexelWidth',
    'Texel Width',
    0.0,
  );

  final NumberParameter _texelHeight = _FloatParameter(
    'inputTexelHeight',
    'Texel Height',
    0.0,
  );

  @override
  String get _previewVertex => 'Sampling3x3PreviewVertex';

  // coverage:ignore-start
  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _texelHeight, _texelWidth];
// coverage:ignore-end
}
