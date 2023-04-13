part of flutter_gpu_video_filters;

/// Describes load image2 methods
mixin Image2Mixin on GPUFilterConfiguration {
  final DataParameter _image2 =
      GLBitmapParameter('inputImageTexture2', 'Image 2');

  // coverage:ignore-start
  @override
  String get _previewVertex => 'VertexPreviewTwoTextures';

  @override
  String get _exportVertex => 'VertexTwoTextures';
  // coverage:ignore-end


  /// Set [_image2] value by [image2].
  set image2(Uint8List value) {
    _image2.data = value;
    _image2.asset = null;
    _image2.file = null;
  }

  /// Set [_image2] value by [image2Asset].
  set image2Asset(String value) {
    _image2.data = null;
    _image2.asset = value;
    _image2.file = null;
  }

  /// Set [_image2] value by [image2File].
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
