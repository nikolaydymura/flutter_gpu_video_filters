part of flutter_gpu_video_filters;

/// Describes Vec3 Parameter updating
class GLVec3Parameter extends Vector3Parameter {
  GLVec3Parameter(super.name, super.displayName, super.value);

  /// Updates the Vec3 Parameter value.
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
