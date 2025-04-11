part of '../../../flutter_gpu_video_filters.dart';

/// Mixin for filters that use two images
mixin Image2Mixin on GPUFilterConfiguration {
  final DataParameter _image2 = GLBitmapParameter(
    'inputImageTexture2',
    'Image 2',
  );

  // coverage:ignore-start
  @override
  String get _previewVertex => 'VertexPreviewTwoTextures';

  @override
  String get _exportVertex => 'VertexTwoTextures';
  // coverage:ignore-end

  /// Set the second image as a byte array
  ///
  /// This will replace the current image with the provided byte array
  set image2(Uint8List value) {
    _image2.data = value;
    _image2.asset = null;
    _image2.file = null;
  }

  /// Set the second image as an asset
  ///
  /// This will replace the current image with the provided asset
  set image2Asset(String value) {
    _image2.data = null;
    _image2.asset = value;
    _image2.file = null;
  }

  /// Set the second image as a file
  ///
  /// This will replace the current image with the provided file
  set image2File(File value) {
    _image2.data = null;
    _image2.asset = null;
    _image2.file = value;
  }

  // coverage:ignore-start
  @override
  List<ConfigurationParameter> get parameters => [...super.parameters, _image2];
  // coverage:ignore-end
}
