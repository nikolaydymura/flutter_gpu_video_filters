part of flutter_gpu_video_filters;

class GPUVideoPreview extends StatelessWidget {
  final GPUVideoPreviewController controller;

  const GPUVideoPreview({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformViewLink(
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: 'GPUVideoPreview',
          layoutDirection: TextDirection.ltr,
          creationParams: {'asset': 'videos/BigBuckBunny.mp4'},
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
      viewType: 'GPUVideoPreview',
    );
  }
}

class GPUVideoPreviewController {
  static final VideoPreviewApi _api = VideoPreviewApi();
  final int _textureId;

  GPUVideoPreviewController._(this._textureId);

  Future<void> setImageAsset(String asset) async {
    await _api.setSource(
      SourcePreviewMessage(textureId: _textureId, path: asset, asset: true),
    );
  }

  Future<void> setImageFile(File file) async {
    await _api.setSource(
      SourcePreviewMessage(
        textureId: _textureId,
        path: file.absolute.path,
        asset: false,
      ),
    );
  }

  static Future<GPUVideoPreviewController> initialize() async {
    final message = await _api.create();
    return GPUVideoPreviewController._(message.textureId);
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
    await _api.connect(
      BindPreviewMessage(
        textureId: _textureId,
        filterId: configuration._filterId,
      ),
    );
  }

  Future<void> disconnect(
    GPUFilterConfiguration configuration, {
    bool disposeConfiguration = false,
  }) async {
    if (disposeConfiguration && configuration.ready) {
      await configuration.dispose();
    }
    await _api.dispose(PreviewMessage(textureId: _textureId));
  }

  Future<void> dispose() async {
    await _api.dispose(PreviewMessage(textureId: _textureId));
  }

  Future<void> play() async {
    await _api.resume(PreviewMessage(textureId: _textureId));
  }

  Future<void> pause() async {
    await _api.pause(PreviewMessage(textureId: _textureId));
  }
}
