part of flutter_gpu_video_filters;

abstract class GPUFilterConfiguration extends FilterConfiguration {
  static final FilterApi _api = FilterApi();

  int _filterId = -1;
  final String name;

  bool get ready => _filterId != -1;

  GPUFilterConfiguration(this.name);

  Future<void> prepare() async {
    if (_filterId == -1) {
      final vertexShader = await rootBundle.loadString(
        'packages/flutter_gpu_video_filters/shaders/Vertex.glsl',
      );
      final fragmentShader = await rootBundle.loadString(
        'packages/flutter_gpu_video_filters/shaders/$name.glsl',
      );
      final filterId = await _api.create(
        vertexShader,
        fragmentShader,
        parameters
            .whereType<NumberParameter>()
            .groupFoldBy((e) => e.name, (_, e) => e.value.toDouble()),
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

  Future<Stream<int>> exportVideoFile(
    VideoExportConfig config, {
    Duration period = const Duration(seconds: 1),
  }) async {
    final source = config.source;
    final output = config.output;
    var format = config.format;
    if (format == VideoExportFormat.auto) {
      format = output.path.endsWith('.mp4')
          ? VideoExportFormat.mp4
          : VideoExportFormat.mov;
    }
    final bool asset = source is AssetInputSource;
    switch (format) {
      case VideoExportFormat.mp4:
        final sessionId = await _api.exportVideoFile(
          _filterId,
          asset,
          source.path,
          output.absolute.path,
          'mp4',
          period.inMilliseconds,
        );
        return EventChannel('Transformer_$sessionId')
            .receiveBroadcastStream()
            .map((event) => event as int)
            .distinct()
            .takeWhile((event) => event != -100);
      case VideoExportFormat.mov:
        final sessionId = await _api.exportVideoFile(
          _filterId,
          asset,
          source.path,
          output.absolute.path,
          'mov',
          period.inMilliseconds,
        );
        return EventChannel('Transformer_$sessionId')
            .receiveBroadcastStream()
            .map((event) => event as int)
            .distinct()
            .takeWhile((event) => event != -100);
      default:
        throw 'Unsupported format $output';
    }
  }
}

abstract class PathInputSource {
  final String path;

  PathInputSource(this.path);
}

class FileInputSource extends PathInputSource {
  final File file;

  FileInputSource(this.file) : super(file.absolute.path);
}

class AssetInputSource extends PathInputSource {
  AssetInputSource(super.path);
}

class VideoExportConfig {
  final PathInputSource source;
  final File output;
  final VideoExportFormat format;

  VideoExportConfig(
    this.source,
    this.output, {
    this.format = VideoExportFormat.auto,
  });
}

enum VideoExportFormat { mp4, mov, auto }
