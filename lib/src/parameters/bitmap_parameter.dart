part of flutter_gpu_video_filters;

class _BitmapParameter extends DataParameter {
  _BitmapParameter(super.name, super.displayName);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (asset != null) {
      await GPUFilterConfiguration._api.setBitmapParameter(
        BitmapFilterMessage(
          filterId: configuration._filterId,
          name: name,
          path: asset!,
          asset: true,
        ),
      );
    } else if (file != null) {
      await GPUFilterConfiguration._api.setBitmapParameter(
        BitmapFilterMessage(
          filterId: configuration._filterId,
          name: name,
          path: file!.absolute.path,
          asset: false,
        ),
      );
    } else if (data != null) {
      await GPUFilterConfiguration._api.setBitmapDataParameter(
        BitmapDataFilterMessage(
          filterId: configuration._filterId,
          name: name,
          data: data!,
        ),
      );
    }
  }
}
