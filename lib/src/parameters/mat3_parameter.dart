part of flutter_gpu_video_filters;

class _Mat3Parameter extends VectorParameter {
  _Mat3Parameter(super.name, super.displayName, super.value, {super.hidden});

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      Float64List.fromList(value),
    );
  }
}
