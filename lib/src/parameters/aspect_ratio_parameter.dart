part of '../../flutter_gpu_video_filters.dart';

/// Aspect ratio parameter for GPU filters
///
/// This parameter is used to pass aspect ratio values to the GPU as `uniform float` variables.
@visibleForTesting
class GLAspectRatioParameter extends AspectRatioParameter {
  /// Create a [GLAspectRatioParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLAspectRatioParameter(super.name, super.displayName, super.value);

  /// Apply updates to the GPU filter
  ///
  /// [configuration] is the connected GPU filter configuration
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await configuration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}
