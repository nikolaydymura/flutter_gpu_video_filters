import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gpu_video_filters_platform_interface.dart';

/// An implementation of [GpuVideoFiltersPlatform] that uses method channels.
class MethodChannelGpuVideoFilters extends GpuVideoFiltersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpu_video_filters');

  @override
  Future<int> prepareFilter(String name) async {
    final filterId =
        await methodChannel.invokeMethod<int>('prepareFilter', name);
    if (filterId == null) {
      throw NullThrownError();
    }
    return filterId;
  }

  @override
  Future<void> disposeFilter(int id) async {
    await methodChannel.invokeMethod<int>('disposeFilter', id);
  }

  @override
  Future<void> updateParameter(int id, String name, dynamic value) async {
    await methodChannel.invokeMethod<int>('updateParameter', [id, name, value]);
  }
}

class MethodChannelGpuVideoPreview extends GpuVideoPreviewsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpu_video_previews');

  @override
  Future<int> createPreview() async {
    final textureId =
        await methodChannel.invokeMethod<int>('createVideoPreview');
    if (textureId == null) {
      throw NullThrownError();
    }
    return textureId;
  }

  @override
  Future<void> setPreviewAsset(int textureId, String asset) async {
    await methodChannel.invokeMethod(
      'setVideoPreviewAsset',
      [textureId, asset],
    );
  }

  @override
  Future<void> setPreviewFile(int textureId, File file) async {
    await methodChannel.invokeMethod(
      'setVideoPreviewFile',
      [textureId, file.absolute.path],
    );
  }

  @override
  Future<void> setPreviewConfiguration(int textureId, int filterId) async {
    await methodChannel.invokeMethod(
      'setVideoPreviewConfiguration',
      [textureId, filterId],
    );
  }

  @override
  Future<void> resumePreview(
    int textureId,
  ) async {
    await methodChannel.invokeMethod(
      'resumeVideoPreview',
      textureId,
    );
  }

  @override
  Future<void> pausePreview(
    int textureId,
  ) async {
    await methodChannel.invokeMethod(
      'pauseVideoPreview',
      textureId,
    );
  }

  @override
  Future<void> destroyPreview(
    int textureId,
  ) async {
    await methodChannel.invokeMethod(
      'destroyVideoPreview',
      textureId,
    );
  }
}
