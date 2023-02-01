part of flutter_gpu_video_filters;

class GPUSquareLookupTableConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final DataParameter _lutImage;

  GPUSquareLookupTableConfiguration()
      : _intensity = _SliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1.0,
          min: 0,
          max: 1,
        ),
        _lutImage = _BitmapParameter('inputTextureCubeData', 'LUT'),
        super('SquareLookupTable');

  set intensity(double value) {
    _intensity.value = value;
  }

  set lutImage(Uint8List value) {
    _lutImage.data = value;
    _lutImage.asset = null;
    _lutImage.file = null;
  }

  set lutImageAsset(String value) {
    _lutImage.data = null;
    _lutImage.asset = value;
    _lutImage.file = null;
  }

  set lutImageFile(File value) {
    _lutImage.data = null;
    _lutImage.asset = null;
    _lutImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _lutImage];
}

class GPUHALDLookupTableConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final DataParameter _lutImage;

  GPUHALDLookupTableConfiguration()
      : _intensity = _SliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1.0,
          min: 0,
          max: 1,
        ),
        _lutImage = _BitmapParameter('inputTextureCubeData', 'LUT'),
        super('HALDLookupTable');

  set intensity(double value) {
    _intensity.value = value;
  }

  set lutImage(Uint8List value) {
    _lutImage.data = value;
    _lutImage.asset = null;
    _lutImage.file = null;
  }

  set lutImageAsset(String value) {
    _lutImage.data = null;
    _lutImage.asset = value;
    _lutImage.file = null;
  }

  set lutImageFile(File value) {
    _lutImage.data = null;
    _lutImage.asset = null;
    _lutImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _lutImage];
}
