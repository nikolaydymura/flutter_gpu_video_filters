part of flutter_gpu_video_filters;

/// Describes Mat3 Parameter updating
class GLMat3Parameter extends Mat3Parameter {
  GLMat3Parameter(super.name, super.displayName, super.value, {super.hidden});

  /// Updates the Mat3 Parameter value.
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
