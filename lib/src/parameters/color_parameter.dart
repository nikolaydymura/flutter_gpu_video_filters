part of '../../flutter_gpu_video_filters.dart';

/// Color parameter for GPU filters
///
/// This parameter is used to pass color values to the GPU as `uniform vec4` variables.
@visibleForTesting
class GLColorParameter extends ColorParameter {
  /// Create a [GLColorParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLColorParameter(super.name, super.displayName, super.value);

  /// Apply updates to the GPU filter
  ///
  /// [configuration] is the connected GPU filter configuration
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await configuration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      floats64,
    );
  }
}
