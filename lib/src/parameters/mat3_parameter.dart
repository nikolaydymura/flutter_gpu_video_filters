part of flutter_gpu_video_filters;

class _Mat3Parameter extends ListParameter {
  _Mat3Parameter(super.name, super.displayName, super.value, {super.hidden});

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      floats64,
    );
  }
}
