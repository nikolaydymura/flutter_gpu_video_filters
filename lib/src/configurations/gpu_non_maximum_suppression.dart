part of '../../flutter_gpu_video_filters.dart';

/// Configuration for the NonMaximumSuppression filter
class GPUNonMaximumSuppressionConfiguration extends GPUFilterConfiguration
    with Sampling3x3Mixin {
  GPUNonMaximumSuppressionConfiguration() : super('NonMaximumSuppression');
}
