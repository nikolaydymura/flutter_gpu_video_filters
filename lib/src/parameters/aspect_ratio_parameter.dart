part of flutter_gpu_video_filters;

/// Describes Aspect Ratio Parameter updating
@visibleForTesting
class GLAspectRatioParameter extends AspectRatioParameter {
  GLAspectRatioParameter(super.name, super.displayName, super.value);

  /// Updates the Aspect Ratio Parameter value.
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
