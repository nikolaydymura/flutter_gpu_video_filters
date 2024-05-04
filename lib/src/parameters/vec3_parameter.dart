part of '../../flutter_gpu_video_filters.dart';

/// Vector 3 parameter for GPU filters
///
/// This parameter is used to pass 3D vector values to the GPU as `uniform vec3` variables.
class GLVec3Parameter extends Vector3Parameter {
  /// Create a [GLVec3Parameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLVec3Parameter(super.name, super.displayName, super.value);

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
