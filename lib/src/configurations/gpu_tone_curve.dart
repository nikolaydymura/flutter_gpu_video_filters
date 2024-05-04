part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the ToneCurve filter
class GPUToneCurveConfiguration extends GPUFilterConfiguration {
  final DataParameter _toneCurveImage;

  GPUToneCurveConfiguration()
      : _toneCurveImage =
            GLBitmapParameter('inputTextureToneCurve', 'Tone Curve Image'),
        super('ToneCurve');

  /// Tone curve image
  set toneCurveImage(Uint8List value) {
    _toneCurveImage.data = value;
    _toneCurveImage.asset = null;
    _toneCurveImage.file = null;
  }

  /// Tone curve image asset
  set toneCurveImageAsset(String value) {
    _toneCurveImage.data = null;
    _toneCurveImage.asset = value;
    _toneCurveImage.file = null;
  }

  /// Tone curve image file
  set toneCurveImageFile(File value) {
    _toneCurveImage.data = null;
    _toneCurveImage.asset = null;
    _toneCurveImage.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_toneCurveImage];
}
