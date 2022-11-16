part of gpu_video_filters;

class GPUVideoPreview extends StatelessWidget {
  final GPUVideoPreviewController controller;

  const GPUVideoPreview({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Texture(textureId: controller._textureId);
  }
}

class GPUVideoPreviewController {
  static final GpuVideoPreviewsPlatform _api =
      GpuVideoPreviewsPlatform.instance;
  final int _textureId;

  GPUVideoPreviewController._(this._textureId);

  Future<void> setImageAsset(String asset) async {
    await _api.setPreviewAsset(_textureId, asset);
  }

  Future<void> setImageFile(File file) async {
    await _api.setPreviewFile(_textureId, file);
  }

  static Future<GPUVideoPreviewController> initialize() async {
    final textureId = await _api.createPreview();
    return GPUVideoPreviewController._(textureId);
  }

  static Future<GPUVideoPreviewController> fromFile(File file) async {
    final controller = await initialize();
    await controller.setImageFile(file);
    return controller;
  }

  static Future<GPUVideoPreviewController> fromAsset(String asset) async {
    final controller = await initialize();
    await controller.setImageAsset(asset);
    return controller;
  }

  Future<void> connect(GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      await configuration.prepare();
    }
    await _api.setPreviewConfiguration(_textureId, configuration._filterId);
  }

  Future<void> disconnect(
    GPUFilterConfiguration configuration, {
    bool disposeConfiguration = false,
  }) async {
    if (disposeConfiguration && configuration.ready) {
      await configuration.dispose();
    }
    await _api.setPreviewConfiguration(_textureId, -1);
  }

  Future<void> dispose() async {
    await _api.destroyPreview(_textureId);
  }

  Future<void> play() async {
    await _api.resumePreview(_textureId);
  }

  Future<void> pause() async {
    await _api.pausePreview(_textureId);
  }
}
