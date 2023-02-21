part of flutter_gpu_video_filters;

class GPUVideoNativePreview extends StatelessWidget {
  final void Function(GPUVideoPreviewController, Stream<Size>) onViewCreated;
  final void Function(Stream<Size>)? onSizeUpdated;
  final GPUFilterConfiguration configuration;
  final GPUVideoPreviewParams params;

  const GPUVideoNativePreview({
    Key? key,
    required this.onViewCreated,
    required this.params,
    required this.configuration,
    this.onSizeUpdated,
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
        controller.connect(configuration).whenComplete(
              () => onViewCreated(
                controller,
                EventChannel('GPUVideoPreviewEvent_$id')
                    .receiveBroadcastStream()
                    .map((event) {
                  return Size(
                    event['width'].toDouble(),
                    event['height'].toDouble(),
                  );
                }).asyncMap((event) async {
                  if (configuration is Sampling3x3Mixin) {
                    final width = configuration.parameters
                        .whereType<NumberParameter>()
                        .firstWhere((e) => e.name == 'inputTexelWidth');
                    width.value = 1 / event.width;
                    final height = configuration.parameters
                        .whereType<NumberParameter>()
                        .firstWhere((e) => e.name == 'inputTexelHeight');
                    height.value = 1 / event.height;
                    await configuration.apply();
                  } else if (configuration is GPUSharpenConfiguration) {
                    final width = configuration.parameters
                        .whereType<NumberParameter>()
                        .firstWhere((e) => e.name == 'inputImageWidthFactor');
                    width.value = 1 / event.width;
                    final height = configuration.parameters
                        .whereType<NumberParameter>()
                        .firstWhere((e) => e.name == 'inputImageHeightFactor');
                    height.value = 1 / event.height;
                    await configuration.apply();
                  }
                  final aspectRatio = configuration.parameters
                      .whereType<AspectRatioParameter>()
                      .firstOrNull;
                  aspectRatio?.value = event;
                  if (aspectRatio != null) {
                    await aspectRatio.update(configuration);
                  }
                  return event;
                }),
              ),
            );
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
  final String? _texture;

  GPUVideoPreviewParams._(
    this._vertexShader,
    this._fragmentShader,
    this._floats,
    this._arrays,
    this._texture,
  );

  static Future<GPUVideoPreviewParams> create(
    GPUFilterConfiguration configuration,
  ) async {
    final vertexShader = await rootBundle.loadString(
      'packages/flutter_gpu_video_filters/shaders/${configuration._previewVertex}.glsl',
    );
    final fragmentShader = await rootBundle.loadString(
      'packages/flutter_gpu_video_filters/shaders/${configuration.name}.glsl',
    );
    final floats = configuration.parameters
        .whereNot((e) => e.compute)
        .whereType<NumberParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

    final booleans = configuration.parameters
        .whereNot((e) => e.compute)
        .whereType<BoolParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

    final ratios = configuration.parameters
        .whereNot((e) => e.compute)
        .whereType<AspectRatioParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

    final arrays = configuration.parameters
        .whereNot((e) => e.compute)
        .whereType<VectorParameter>()
        .groupFoldBy((e) => e.name, (_, e) => e.float32);

    final textures = configuration.parameters
        .whereType<GLBitmapParameter>()
        .singleOrNull
        ?.name;
    var glsl =
        '#extension GL_OES_EGL_image_external : require\n${fragmentShader.replaceAll('sampler2D inputImageTexture;', 'samplerExternalOES inputImageTexture;')}';
    if (textures != null) {
      glsl = glsl.replaceAll(
        RegExp(
          r'^[^\n]* sampler2D ' '$textures;' r'[^\n]*$',
          multiLine: true,
          caseSensitive: false,
          dotAll: true,
        ),
        'uniform sampler2D $textures;\nuniform lowp float ${textures}Ready;\n',
      );
      glsl = glsl.replaceAllMapped(
          RegExp(
            r'gl_FragColor\s+=\s+[^;]+;$',
            multiLine: true,
            dotAll: true,
          ), (match) {
        return 'if (${textures}Ready == 1.0) {\n\t\t${match.group(0)}\n\t} else {\n\t\tgl_FragColor = textureColor;\n\t}';
      });
    }
    return GPUVideoPreviewParams._(
      vertexShader,
      glsl,
      floats
        ..addAll(booleans)
        ..addAll(ratios),
      arrays,
      textures,
    );
  }

  Map<String, dynamic> toJson() {
    return Map.unmodifiable({
      'vertex': _vertexShader,
      'fragment': _fragmentShader,
      ..._floats,
      ..._arrays,
      if (_texture != null) 'textureName': _texture,
    });
  }
}
