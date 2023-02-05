part of flutter_gpu_video_filters;

class _Vec3Parameter extends VectorParameter {
  _Vec3Parameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      Float64List.fromList(value),
    );
  }
}
