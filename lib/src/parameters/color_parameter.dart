part of gpu_video_filters;

class _ColorParameter extends ColorParameter {
  _ColorParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.updateParameter(
      configuration._filterId,
      name,
      [value.red / 255.0, value.green / 255.0, value.blue / 255.0],
    );
  }
}
