part of flutter_gpu_video_filters;

class GPUVideoNativePreview extends StatelessWidget {
  final void Function(GPUVideoPreviewController) onViewCreated;
  final GPUFilterConfiguration configuration;
  final GPUVideoPreviewParams params;

  const GPUVideoNativePreview({
    Key? key,
    required this.onViewCreated,
    required this.params,
    required this.configuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'GPUVideoPreview',
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: const StandardMessageCodec(),
      creationParams: params.toJson(),
      onPlatformViewCreated: (id) {
        final controller = GPUVideoPreviewController._(id, true);
        controller.connect(configuration);
        onViewCreated(controller);
      },
    );
  }
}

class GPUVideoSurfacePreview extends StatelessWidget {
  final void Function(GPUVideoPreviewController) onViewCreated;

  const GPUVideoSurfacePreview({Key? key, required this.onViewCreated})
      : super(key: key);

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
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener((texture) {
            params.onPlatformViewCreated(texture);
            onViewCreated(GPUVideoPreviewController._(texture, true));
          })
          ..create();
      },
      viewType: 'GPUVideoPreview',
    );
  }
}

class GPUVideoPreviewParams {
  final String _vertexShader;
  final String _fragmentShader;
  final Map<String, double> _floats;
  final Map<String, Float32List> _arrays;

  GPUVideoPreviewParams._(
    this._vertexShader,
    this._fragmentShader,
    this._floats,
    this._arrays,
  );

  static Future<GPUVideoPreviewParams> create(
    GPUFilterConfiguration configuration,
  ) async {
    final vertexShader = await rootBundle.loadString(
      'packages/flutter_gpu_video_filters/shaders/PreviewVertex.glsl',
    );
    final fragmentShader = await rootBundle.loadString(
      'packages/flutter_gpu_video_filters/shaders/${configuration.name}.glsl',
    );
    final floats = configuration.parameters
        .whereType<NumberParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.value.toDouble());
    final arrays = configuration.parameters
        .whereType<_FloatsParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.floats);
    return GPUVideoPreviewParams._(
      vertexShader,
      fragmentShader,
      floats,
      arrays,
    );
  }

  Map<String, dynamic> toJson() {
    return Map.unmodifiable({
      'vertex': _vertexShader,
      'fragment': _fragmentShader,
      ..._floats,
      ..._arrays
    });
  }
}
