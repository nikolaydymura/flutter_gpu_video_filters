part of flutter_gpu_video_filters;

/// Describes square lookup table manipulations
class GPUSquareLookupTableConfiguration extends GPUFilterConfiguration {
  final NumberParameter _intensity;
  final DataParameter _lutImage;

  GPUSquareLookupTableConfiguration()
      : _intensity = GLSliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1.0,
          min: 0,
          max: 1,
        ),
        _lutImage = GLBitmapParameter('inputTextureCubeData', 'Lookup Image'),
        super('SquareLookupTable');

  /// Updates the [intensity] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Updates the [lutImage] value.
  set lutImage(Uint8List value) {
    _lutImage.data = value;
    _lutImage.asset = null;
    _lutImage.file = null;
  }

  /// Updates the [lutImageAsset] value.
  set lutImageAsset(String value) {
    _lutImage.data = null;
    _lutImage.asset = value;
    _lutImage.file = null;
  }

  /// Updates the [lutImageFile] value.
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
      : _intensity = GLSliderFloatParameter(
          'inputIntensity',
          'Intensity',
          1.0,
          min: 0,
          max: 1,
        ),
        _lutImage = GLBitmapParameter('inputTextureCubeData', 'Lookup Image'),
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
