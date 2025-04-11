part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Kuwahara filter
class GPUKuwaharaConfiguration extends GPUFilterConfiguration {
  final NumberParameter _radius;

  GPUKuwaharaConfiguration()
    : _radius = GLIntParameter('inputRadius', 'Radius', 3),
      super('Kuwahara');

  /// Radius of the filter
  ///
  /// The default value is 3
  set radius(int value) {
    _radius.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_radius];
}
