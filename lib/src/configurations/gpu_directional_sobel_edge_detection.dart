part of flutter_gpu_video_filters;

class GPUDirectionalSobelEdgeDetectionConfiguration
    extends GPUFilterConfiguration with Sampling3x3Mixin {
  GPUDirectionalSobelEdgeDetectionConfiguration()
      : super('DirectionalSobelEdgeDetection');
}
