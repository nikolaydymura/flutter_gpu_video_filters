part of flutter_gpu_video_filters;

/// Describes directional Sobel edge detection manipulations
class GPUDirectionalSobelEdgeDetectionConfiguration
    extends GPUFilterConfiguration with Sampling3x3Mixin {
  GPUDirectionalSobelEdgeDetectionConfiguration()
      : super('DirectionalSobelEdgeDetection');
}
