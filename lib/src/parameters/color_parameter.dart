part of flutter_gpu_video_filters;

class _ColorParameter extends ColorParameter with _FloatsParameter {
  _ColorParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    await GPUFilterConfiguration._api.setFloatArrayParameter(
      configuration._filterId,
      name,
      Float64List.fromList(values),
    );
  }

  @override
  List<double> get values =>
      [value.red / 255.0, value.green / 255.0, value.blue / 255.0];
}
