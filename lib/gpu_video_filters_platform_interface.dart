import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gpu_video_filters_method_channel.dart';

abstract class GpuVideoFiltersPlatform extends PlatformInterface {
  /// Constructs a GpuVideoFiltersPlatform.
  GpuVideoFiltersPlatform() : super(token: _token);

  static final Object _token = Object();

  static GpuVideoFiltersPlatform _instance = MethodChannelGpuVideoFilters();

  /// The default instance of [GpuVideoFiltersPlatform] to use.
  ///
  /// Defaults to [MethodChannelGpuVideoFilters].
  static GpuVideoFiltersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GpuVideoFiltersPlatform] when
  /// they register themselves.
  static set instance(GpuVideoFiltersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int> prepareFilter(String name);

  Future<void> disposeFilter(int id);

  Future<void> updateParameter(int id, String name, dynamic value);
}
