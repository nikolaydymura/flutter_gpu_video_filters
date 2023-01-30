part of flutter_gpu_video_filters;

abstract class GPUFilterConfiguration extends FilterConfiguration {
  static final FilterApi _api = FilterApi();

  int _filterId = -1;
  final String name;

  bool get ready => _filterId != -1;

  GPUFilterConfiguration(this.name);

  Future<void> prepare() async {
    if (_filterId == -1) {
      final fragmentShader = await rootBundle.loadString(
        'packages/flutter_gpu_video_filters/shaders/$name.glsl',
      );
      final filterId = await _api.create(fragmentShader);
      _filterId = filterId;
    }
  }

  Future<void> dispose() async {
    if (_filterId >= 0) {
      await _api.dispose(_filterId);
    }
    _filterId = -1;
  }

  Future<void> apply() async {
    for (final parameter in parameters) {
      await parameter.update(this);
    }
  }
}
