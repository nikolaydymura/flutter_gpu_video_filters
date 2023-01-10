part of flutter_gpu_video_filters;

class _ColorParameter extends ColorParameter {
  _ColorParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatArrayParameter(FloatArrayFilterMessage(
        filterId: configuration._filterId,
        name: name,
        value: [value.red / 255.0, value.green / 255.0, value.blue / 255.0]));
  }
}
