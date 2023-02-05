part of flutter_gpu_video_filters;

class GPUKuwaharaConfiguration extends GPUFilterConfiguration {
  final NumberParameter _radius;

  GPUKuwaharaConfiguration()
      : _radius = _IntParameter('inputRadius', 'Radius', 3),
        super('Kuwahara');

  set radius(int value) {
    _radius.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_radius];
}
