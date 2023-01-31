part of flutter_gpu_video_filters;

class GPUVideoTexturePreview extends StatelessWidget {
  final GPUVideoPreviewController controller;

  const GPUVideoTexturePreview({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Texture(textureId: controller._textureId);
  }
}

class GPUVideoPreviewController {
  static final VideoPreviewApi _api = VideoPreviewApi();
  final int _textureId;
  final bool _embedded;

  GPUVideoPreviewController._(this._textureId, this._embedded);

  Future<void> setVideoAsset(String asset) async {
    await _api.setSource(
      SourcePreviewMessage(textureId: _textureId, path: asset, asset: true),
      _embedded,
    );
  }

  Future<void> setVideoFile(File file) async {
    await _api.setSource(
      SourcePreviewMessage(
        textureId: _textureId,
        path: file.absolute.path,
        asset: false,
      ),
      _embedded,
    );
  }

  static Future<GPUVideoPreviewController> initialize() async {
    final textureId = await _api.create();
    return GPUVideoPreviewController._(textureId, false);
  }

  static Future<GPUVideoPreviewController> fromFile(File file) async {
    final controller = await initialize();
    await controller.setVideoFile(file);
    return controller;
  }

  static Future<GPUVideoPreviewController> fromAsset(String asset) async {
    final controller = await initialize();
    await controller.setVideoAsset(asset);
    return controller;
  }

  Future<void> connect(GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      await configuration.prepare();
    }
    await _api.connect(
      _textureId,
      configuration._filterId,
      _embedded,
    );
  }

  Future<void> disconnect(
    GPUFilterConfiguration configuration, {
    bool disposeConfiguration = false,
  }) async {
    if (disposeConfiguration && configuration.ready) {
      await configuration.dispose();
    }
    await _api.dispose(_textureId, _embedded);
  }

  Future<void> dispose() async {
    await _api.dispose(_textureId, _embedded);
  }

  Future<void> play() async {
    await _api.resume(_textureId, _embedded);
  }

  Future<void> pause() async {
    await _api.pause(_textureId, _embedded);
  }
}
