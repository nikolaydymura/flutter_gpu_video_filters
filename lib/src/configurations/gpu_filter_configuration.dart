part of gpu_video_filters;

abstract class GPUFilterConfiguration extends FilterConfiguration {
  static final GpuVideoFiltersPlatform _api =
      GpuVideoFiltersPlatform.instance;

  int _filterId = -1;
  final String name;

  bool get ready => _filterId != -1;

  GPUFilterConfiguration(this.name);

  Future<void> prepare() async {
    if (_filterId == -1) {
      _filterId = await _api.prepareFilter(name);
    }
  }

  Future<void> dispose() async {
    if (_filterId >= 0) {
      await _api.disposeFilter(_filterId);
    }
    _filterId = -1;
  }
}
