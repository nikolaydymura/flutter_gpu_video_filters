part of flutter_gpu_video_filters;

class _PointParameter extends PointParameter {
  _PointParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      [value.x, value.y],
    );
  }
}
