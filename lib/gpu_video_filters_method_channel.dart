import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gpu_video_filters_platform_interface.dart';

/// An implementation of [GpuVideoFiltersPlatform] that uses method channels.
class MethodChannelGpuVideoFilters extends GpuVideoFiltersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpu_video_filters');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
