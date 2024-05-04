part of '../../flutter_gpu_video_filters.dart';

/// Point parameter for GPU filters
///
/// This parameter is used to pass point values to the GPU as `uniform vec2` variables.
@visibleForTesting
class GLPointParameter extends PointParameter {
  /// Create a [GLPointParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLPointParameter(super.name, super.displayName, super.value);

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
