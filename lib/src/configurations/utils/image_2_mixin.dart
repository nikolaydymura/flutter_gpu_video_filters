part of flutter_gpu_video_filters;

mixin Image2Mixin on GPUFilterConfiguration {
  final DataParameter _image2 =
      _BitmapParameter('inputImageTexture2', 'Image 2');

  @override
  String get _previewVertex => 'TwoTexturesPreviewVertex';

  set image2(Uint8List value) {
    _image2.data = value;
    _image2.asset = null;
    _image2.file = null;
  }

  set image2Asset(String value) {
    _image2.data = null;
    _image2.asset = value;
    _image2.file = null;
  }

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
