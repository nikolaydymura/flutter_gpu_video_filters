// coverage:ignore-file
part of '../flutter_gpu_video_filters.dart';

/// Controller for the video preview
class GPUVideoPreviewController extends VideoPreviewController {
  static final VideoPreviewApi _api = VideoPreviewApi();
  @override
  final int textureId;
  final bool _embedded;

  GPUVideoPreviewController._(this.textureId, this._embedded);

  /// Set the video source
  ///
  /// [source] is the video source
  @override
  Future<void> setVideoSource(PathInputSource source) async {
    if (source is FileInputSource) {
      await _api.setSource(textureId, source.path, false, _embedded);
    } else if (source is AssetInputSource) {
      await _api.setSource(textureId, source.path, true, _embedded);
    }
  }

  /// Initialize the controller
  static Future<VideoPreviewController> initialize() async {
    final textureId = await _api.create();
    return GPUVideoPreviewController._(textureId, false);
  }

  /// Create a controller from a file
  ///
  /// [file] is the video file
  static Future<VideoPreviewController> fromFile(File file) async {
    final controller = await initialize();
    await controller.setVideoSource(FileInputSource(file));
    return controller;
  }

  /// Create a controller from an asset
  ///
  /// [asset] is the video asset
  static Future<VideoPreviewController> fromAsset(String asset) async {
    final controller = await initialize();
    await controller.setVideoSource(AssetInputSource(asset));
    return controller;
  }

  /// Connect controller to a filter
  ///
  /// [configuration] is the filter configuration
  @override
  Future<void> connect(covariant GPUFilterConfiguration configuration) async {
    await super.connect(configuration);
    await _api.connect(textureId, configuration._filterId, _embedded);
  }

  /// Disconnect controller from a filter
  @override
  Future<void> disconnect() async {
    await _api.disconnect(textureId, _embedded);
  }

  /// Dispose the controller
  @override
  Future<void> dispose() async {
    await _api.dispose(textureId, _embedded);
  }

  /// Play the video
  @override
  Future<void> play() async {
    await _api.resume(textureId, _embedded);
  }

  /// Pause the video
  @override
  Future<void> pause() async {
    await _api.pause(textureId, _embedded);
  }
}
