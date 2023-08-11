part of flutter_gpu_video_filters;

/// Describes non maximum suppression manipulations
class GPUNonMaximumSuppressionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  GPUNonMaximumSuppressionConfiguration() : super('NonMaximumSuppression');
}
