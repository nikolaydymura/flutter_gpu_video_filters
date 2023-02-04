part of flutter_gpu_video_filters;

abstract class GPUFilterConfiguration extends FilterConfiguration
    with VideoFilterConfiguration {
  static final FilterApi _api = FilterApi();

  int _filterId = -1;
  final String name;

  bool get ready => _filterId != -1;

  final String _previewVertex = 'VertexPreview';

  final String _exportVertex = 'Vertex';

  GPUFilterConfiguration(this.name);

  Future<void> prepare() async {
    if (_filterId == -1) {
      final vertexShader = await rootBundle.loadString(
        'packages/flutter_gpu_video_filters/shaders/$_exportVertex.glsl',
      );
      final fragmentShader = await rootBundle.loadString(
        'packages/flutter_gpu_video_filters/shaders/$name.glsl',
      );

      final floats = parameters
          .whereType<NumberParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.value.toDouble());

      final arrays = parameters
          .whereType<_FloatsParameter>()
          .groupFoldBy((e) => e.name, (_, e) => e.values);

      final textures =
          parameters.whereType<_BitmapParameter>().singleOrNull?.name;

      final filterId = await _api.create(
        vertexShader,
        fragmentShader,
        floats,
        arrays,
        textures,
      );
      _filterId = filterId;
    }
  }

  Future<void> dispose() async {
    if (_filterId >= 0) {
      await _api.dispose(_filterId);
    }
    _filterId = -1;
  }

  Future<void> apply() async {
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
