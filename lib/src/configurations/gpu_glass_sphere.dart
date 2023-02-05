part of flutter_gpu_video_filters;

class GPUGlassSphereConfiguration extends GPUFilterConfiguration
    with Image2Mixin {
  final NumberParameter _radius;
  final NumberParameter _aspectRatio;
  final NumberParameter _refractiveIndex;

  GPUGlassSphereConfiguration()
      : _radius = _FloatParameter('inputRadius', 'Radius', 0),
        _aspectRatio = _FloatParameter('inputAspectRatio', 'Aspect Ratio', 0),
        _refractiveIndex =
            _FloatParameter('inputRefractiveIndex', 'Refractive Index', 0),
        super('GlassSphere');

  set radius(double value) {
    _radius.value = value;
  }

  set aspectRatio(double value) {
    _aspectRatio.value = value;
  }

  set refractiveIndex(double value) {
    _refractiveIndex.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_radius, _aspectRatio, _refractiveIndex, _image2];
}
