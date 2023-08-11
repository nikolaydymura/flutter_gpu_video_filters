part of flutter_gpu_video_filters;

/// Describes Mat4 Parameter updating
class GLMat4Parameter extends Mat4Parameter {
  GLMat4Parameter(super.name, super.displayName, super.value, {super.hidden});

  /// Updates the Mat4 Parameter value.
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
