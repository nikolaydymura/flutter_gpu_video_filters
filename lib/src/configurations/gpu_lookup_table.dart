part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the LookupTable filter
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

  /// Set the intensity of the filter
  ///
  /// The intensity of the filter. A value of 0.0 will have no effect on the image, while a value of 1.0 will apply the full effect.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Set the lookup image for the filter
  ///
  /// The lookup image to use for the filter. The image should be a square image with a size of 2^n where n is an integer.
  set lutImage(Uint8List value) {
    _lutImage.data = value;
    _lutImage.asset = null;
    _lutImage.file = null;
  }

  /// Set the lookup image for the filter from an asset
  ///
  /// The lookup image to use for the filter. The image should be a square image with a size of 2^n where n is an integer.
  set lutImageAsset(String value) {
    _lutImage.data = null;
    _lutImage.asset = value;
    _lutImage.file = null;
  }

  /// Set the lookup image for the filter from a file
  ///
  /// The lookup image to use for the filter. The image should be a square image with a size of 2^n where n is an integer.
  set lutImageFile(File value) {
    _lutImage.data = null;
    _lutImage.asset = null;
    _lutImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _lutImage];
}

/// Configuration for the HALDLookupTable filter
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

  /// Set the intensity of the filter
  ///
  /// The intensity of the filter. A value of 0.0 will have no effect on the image, while a value of 1.0 will apply the full effect.
  set intensity(double value) {
    _intensity.value = value;
  }

  /// Set the lookup image for the filter
  ///
  /// The lookup image to use for the filter.
  set lutImage(Uint8List value) {
    _lutImage.data = value;
    _lutImage.asset = null;
    _lutImage.file = null;
  }

  /// Set the lookup image for the filter from an asset
  ///
  /// The lookup image to use for the filter.
  set lutImageAsset(String value) {
    _lutImage.data = null;
    _lutImage.asset = value;
    _lutImage.file = null;
  }

  /// Set the lookup image for the filter from a file
  ///
  /// The lookup image to use for the filter.
  set lutImageFile(File value) {
    _lutImage.data = null;
    _lutImage.asset = null;
    _lutImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _lutImage];
}
