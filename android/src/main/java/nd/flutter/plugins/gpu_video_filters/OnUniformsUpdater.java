package nd.flutter.plugins.gpu_video_filters;

import android.graphics.Bitmap;

public interface OnUniformsUpdater {
    void setFloatUniform(String name, float value);
    void setFloatsUniform(String name, float[] value);

    void setBitmapUniform(String name, Bitmap value);
}
