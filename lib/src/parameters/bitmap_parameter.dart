part of '../../flutter_gpu_video_filters.dart';

/// Bitmap parameter for GPU filters
///
/// This parameter is used to pass bitmap values to the GPU as `uniform sampler2D` variables.
@visibleForTesting
class GLBitmapParameter extends DataParameter {
  /// Create a [GLBitmapParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  GLBitmapParameter(super.name, super.displayName);

  /// Apply updates to the GPU filter
  ///
  /// [configuration] is the connected GPU filter configuration
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    if (asset != null) {
      await configuration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        true,
        asset!,
      );
    } else if (file != null) {
      await configuration._api.setBitmapSourceParameter(
        configuration._filterId,
        name,
        false,
        file!.absolute.path,
      );
    } else if (data != null) {
      await configuration._api.setBitmapParameter(
        configuration._filterId,
        name,
        data!,
      );
    }
  }
}
