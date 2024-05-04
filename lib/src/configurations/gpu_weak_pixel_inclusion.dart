part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the WeakPixelInclusion filter
class GPUWeakPixelInclusionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  GPUWeakPixelInclusionConfiguration() : super('WeakPixelInclusion');
}
