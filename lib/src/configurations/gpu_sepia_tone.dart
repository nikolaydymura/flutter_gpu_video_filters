part of '../../flutter_gpu_video_filters.dart';

class GPUSepiaToneConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final Mat4Parameter _colorMatrix;

  GPUSepiaToneConfiguration()
      : _intensity = GLFloatParameter('inputIntensity', 'Intensity', 1.0),
        _colorMatrix = GLMat4Parameter(
          'inputColorMatrix',
          'Color Matrix',
          Matrix4(
            0.3588,
            0.7044,
            0.1368,
            0.0,
            0.2990,
            0.5870,
            0.1140,
            0.0,
            0.2392,
            0.4696,
            0.0912,
            0.0,
            0,
            0,
            0,
            1.0,
          ),
          hidden: true,
        ),
        super('ColorMatrix');

  set intensity(double value) {
    _intensity.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _colorMatrix];
}
