part of '../../flutter_gpu_video_filters.dart';

/// Matrix 4x4 parameter for GPU filters
///
/// This parameter is used to pass 4x4 matrices to the GPU as `uniform mat4` variables.
class GLMat4Parameter extends Mat4Parameter {
  /// Create a [GLMat4Parameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLMat4Parameter(super.name, super.displayName, super.value, {super.hidden});

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
