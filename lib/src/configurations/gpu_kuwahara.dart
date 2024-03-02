part of '../../flutter_gpu_video_filters.dart';

class GPUKuwaharaConfiguration extends GPUFilterConfiguration {
  final NumberParameter _radius;

  GPUKuwaharaConfiguration()
      : _radius = GLIntParameter('inputRadius', 'Radius', 3),
        super('Kuwahara');

  set radius(int value) {
    _radius.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_radius];
}
