part of flutter_gpu_video_filters;

/// Describes tone curve manipulations
class GPUToneCurveConfiguration extends GPUFilterConfiguration {
  final DataParameter _toneCurveImage;

  GPUToneCurveConfiguration()
      : _toneCurveImage =
            GLBitmapParameter('inputTextureToneCurve', 'Tone Curve Image'),
        super('ToneCurve');

  /// Updates the [toneCurveImage] value.
  set toneCurveImage(Uint8List value) {
    _toneCurveImage.data = value;
    _toneCurveImage.asset = null;
    _toneCurveImage.file = null;
  }

  /// Updates the [toneCurveImageAsset] value.
  set toneCurveImageAsset(String value) {
    _toneCurveImage.data = null;
    _toneCurveImage.asset = value;
    _toneCurveImage.file = null;
  }

  /// Updates the [toneCurveImageFile] value.
  set toneCurveImageFile(File value) {
    _toneCurveImage.data = null;
    _toneCurveImage.asset = null;
    _toneCurveImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_toneCurveImage];
}
