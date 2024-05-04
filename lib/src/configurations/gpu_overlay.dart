part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the Overlay filter
class GPUOverlayConfiguration extends GPUFilterConfiguration with Image2Mixin {
  GPUOverlayConfiguration() : super('Overlay');

  // coverage:ignore-start
  @override
  String get _previewVertex => 'VertexPreview';

  @override
  String get _exportVertex => 'Vertex';
  // coverage:ignore-end
}
