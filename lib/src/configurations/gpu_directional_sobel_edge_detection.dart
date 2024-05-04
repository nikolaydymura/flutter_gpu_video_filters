part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the DirectionalSobelEdgeDetection filter
class GPUDirectionalSobelEdgeDetectionConfiguration
    extends GPUFilterConfiguration with Sampling3x3Mixin {
  GPUDirectionalSobelEdgeDetectionConfiguration()
      : super('DirectionalSobelEdgeDetection');
}
