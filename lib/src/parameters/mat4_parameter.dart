part of '../../flutter_gpu_video_filters.dart';

class GLMat4Parameter extends Mat4Parameter {
  GLMat4Parameter(super.name, super.displayName, super.value, {super.hidden});

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
