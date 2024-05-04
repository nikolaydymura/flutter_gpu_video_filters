part of '../../flutter_gpu_video_filters.dart';

/// Matrix 3x3 parameter for GPU filters
///
/// This parameter is used to pass 3x3 matrices to the GPU as `uniform mat3` variables.
class GLMat3Parameter extends Mat3Parameter {
  /// Create a [GLMat3Parameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLMat3Parameter(super.name, super.displayName, super.value, {super.hidden});

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
