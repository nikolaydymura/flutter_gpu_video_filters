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
  String get _previewVertex => 'VertexPreviewSampling3x3';

  @override
  String get _exportVertex => 'VertexSampling3x3';

  // coverage:ignore-start
  @override
  List<ConfigurationParameter> get parameters =>
      [...super.parameters, _texelHeight, _texelWidth];
// coverage:ignore-end
}
