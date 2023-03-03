part of flutter_gpu_video_filters;

abstract class GPUFilterConfiguration extends FilterConfiguration
    with VideoFilterConfiguration {
  final FilterApi _api;
  final AssetBundle _assetBundle;
  final String _vertexShadersPath;
  final String _fragmentShadersPath;

  int _filterId = -1;
  final String name;

  @override
  bool get ready => _filterId != -1;

  final String _previewVertex = 'VertexPreview';

  final String _exportVertex = 'Vertex';

  GPUFilterConfiguration(
    this.name, {
    String vertexShadersPath = 'packages/flutter_gpu_video_filters/shaders',
    String fragmentShadersPath = 'packages/flutter_gpu_video_filters/shaders',
    @visibleForTesting FilterApi? filterApi,
    @visibleForTesting AssetBundle? assetBundle,
  })  : _api = filterApi ?? FilterApi(),
        _assetBundle = assetBundle ?? rootBundle,
        _vertexShadersPath = vertexShadersPath,
        _fragmentShadersPath = fragmentShadersPath;

  @override
  FutureOr<void> prepare() async {
    if (_filterId == -1) {
      final vertexShader = await _assetBundle.loadString(
        '$_vertexShadersPath/$_exportVertex.glsl',
      );
      final fragmentShader = await _assetBundle.loadString(
        '$_fragmentShadersPath/$name.glsl',
      );

      final floats = parameters
          .whereNot((e) => e.compute)
          .whereType<NumberParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

      final booleans = parameters
          .whereNot((e) => e.compute)
          .whereType<BoolParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

      final ratios = parameters
          .whereNot((e) => e.compute)
          .whereType<AspectRatioParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.floatValue);

      final arrays = parameters
          .whereNot((e) => e.compute)
          .whereType<VectorParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.floats64);

      final textures =
          parameters.whereType<GLBitmapParameter>().singleOrNull?.name;

      final filterId = await _api.create(
        vertexShader,
        fragmentShader,
        floats
          ..addAll(booleans)
          ..addAll(ratios),
        arrays,
        textures,
      );
      _filterId = filterId;
    }
  }

  @override
  Future<void> dispose() async {
    if (_filterId >= 0) {
      await _api.dispose(_filterId);
    }
    _filterId = -1;
  }

  @override
  Future<void> update() async {
    for (final parameter in parameters) {
      await parameter.update(this);
    }
  }

  @override
  Stream<double> exportVideoFile(
    VideoExportConfig config, {
    Duration period = const Duration(seconds: 1),
  }) async* {
    final source = config.source;
    final output = config.output;
    var format = config.format;
    if (format == VideoExportFormat.auto) {
      format = output.path.endsWith('.mp4')
          ? VideoExportFormat.mp4
          : VideoExportFormat.mov;
    }
    final bool asset = source is AssetInputSource;
    final sessionId = await _api.exportVideoFile(
      _filterId,
      asset,
      source.path,
      output.absolute.path,
      format.platformKey,
      period.inMilliseconds,
    );

    final stream = EventChannel('Transformer_$sessionId')
        .receiveBroadcastStream()
        .distinct();
    await for (num event in stream) {
      yield event.toDouble() / 100.0;
    }
  }

  // coverage:ignore-start
  @override
  List<ConfigurationParameter> get parameters => [];
// coverage:ignore-end
}

class BunchFilterConfiguration extends GPUFilterConfiguration {
  final List<GPUFilterConfiguration> _configurations;

  BunchFilterConfiguration(String fragmentShaders, this._configurations)
      : super(
          _configurations.map((e) => e.name).join('+'),
          fragmentShadersPath: fragmentShaders,
        );

  T configuration<T extends GPUFilterConfiguration>({required int at}) =>
      _configurations[at] as T;

  @override
  List<ConfigurationParameter> get parameters =>
      _configurations.map((e) => e.parameters).expand((e) => e).toList();
}
