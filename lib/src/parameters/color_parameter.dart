part of flutter_gpu_video_filters;

/// Describes Color Parameter updating
@visibleForTesting
class GLColorParameter extends ColorParameter {
  GLColorParameter(super.name, super.displayName, super.value);

  /// Updates the Color Parameter value.
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
