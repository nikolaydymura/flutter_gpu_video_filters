part of flutter_gpu_video_filters;

class GPUNonMaximumSuppressionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  GPUNonMaximumSuppressionConfiguration() : super('NonMaximumSuppression');
}
