package nd.flutter.plugins.gpu_video_filters;

public interface OnUniformsUpdater {
    void setFloatUniform(String name, float value);

    void setFloatsUniform(String name, float[] value);
}
