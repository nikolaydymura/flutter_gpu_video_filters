part of flutter_gpu_video_filters;

class _PointParameter extends PointParameter {
  _PointParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api
        .setFloatArrayParameter(FloatArrayFilterMessage(
      filterId: configuration._filterId,
      name: name,
      value: [value.x, value.y],
    ));
  }
}
