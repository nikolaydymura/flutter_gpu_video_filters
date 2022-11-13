
import 'gpu_video_filters_platform_interface.dart';

class GpuVideoFilters {
  Future<String?> getPlatformVersion() {
    return GpuVideoFiltersPlatform.instance.getPlatformVersion();
  }
}
