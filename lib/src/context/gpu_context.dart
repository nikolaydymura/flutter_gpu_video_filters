part of flutter_gpu_video_filters;

enum GPUContext { egl, mlt, system }

extension _GPUContext on GPUContext {
  String get platformKey {
    switch (this) {
      case GPUContext.egl:
        return 'openGLES2';
      case GPUContext.mlt:
        return 'MLT';
      case GPUContext.system:
        return 'system';
    }
  }
}

extension ProcessingDouble on double {
  // coverage:ignore-start
  bool get isProcessingCompleted => this == -100;
  // coverage:ignore-end
}
