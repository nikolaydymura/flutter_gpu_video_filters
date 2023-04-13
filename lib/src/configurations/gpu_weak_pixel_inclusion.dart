part of flutter_gpu_video_filters;

/// Describes weak pixel inclusion manipulations
class GPUWeakPixelInclusionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  GPUWeakPixelInclusionConfiguration() : super('WeakPixelInclusion');
}
