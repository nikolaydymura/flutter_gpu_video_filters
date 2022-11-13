import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_gpu_video_filters/gpu_video_filters_platform_interface.dart';
import 'package:flutter_gpu_video_filters/gpu_video_filters_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGpuVideoFiltersPlatform
    with MockPlatformInterfaceMixin
    implements GpuVideoFiltersPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GpuVideoFiltersPlatform initialPlatform = GpuVideoFiltersPlatform.instance;

  test('$MethodChannelGpuVideoFilters is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGpuVideoFilters>());
  });

  test('getPlatformVersion', () async {
    GpuVideoFilters gpuVideoFiltersPlugin = GpuVideoFilters();
    MockGpuVideoFiltersPlatform fakePlatform = MockGpuVideoFiltersPlatform();
    GpuVideoFiltersPlatform.instance = fakePlatform;

    expect(await gpuVideoFiltersPlugin.getPlatformVersion(), '42');
  });
}
