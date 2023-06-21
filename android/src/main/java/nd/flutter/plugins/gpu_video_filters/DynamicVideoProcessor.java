/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package nd.flutter.plugins.gpu_video_filters;

import static com.google.android.exoplayer2.util.Assertions.checkNotNull;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.opengl.GLES20;
import android.opengl.GLUtils;
import android.os.Handler;
import android.os.Looper;

import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;
import com.google.android.exoplayer2.util.Log;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.microedition.khronos.opengles.GL10;

import io.flutter.plugin.common.EventChannel;

/**
 * Video processor that demonstrates how to overlay a bitmap on video output using a GL shader. The
 * bitmap is drawn using an Android {@link Canvas}.
 */
/* package */ public final class DynamicVideoProcessor
        implements VideoProcessingGLSurfaceView.VideoProcessor, EventChannel.StreamHandler {

    private final String vertexShader;
    private final String fragmentShader;
    private final Map<String, Float> currentFloats = new HashMap<>();
    private final Map<String, float[]> currentArrayFloats = new HashMap<>();
    private final int[] textures;
    private final String secondTexture;
    private Bitmap secondBitmap;
    private GlProgram program;

    private EventChannel.EventSink eventSink;
    private int outputWith = -1;
    private int outputHeight = -1;

    private Handler mainHandler = new Handler(Looper.getMainLooper());

    public DynamicVideoProcessor(String vertexShader,
                                 String fragmentShader,
                                 Map<String, Float> fragmentDefaultFloats,
                                 Map<String, float[]> fragmentDefaultArrayFloats,
                                 String secondTexture) {
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        for (String key : fragmentDefaultFloats.keySet()) {
            currentFloats.put(key, checkNotNull(fragmentDefaultFloats.get(key)));
        }
        for (String key : fragmentDefaultArrayFloats.keySet()) {
            float[] values = checkNotNull(fragmentDefaultArrayFloats.get(key));
            currentArrayFloats.put(key, values);
        }
        this.secondTexture = secondTexture;
        this.textures = new int[secondTexture != null ? 1 : 0];
    }
    @Override
    public void initialize() {
        try {
            program = new GlProgram(vertexShader, fragmentShader);
        } catch (GlUtil.GlException e) {
            Log.e(getClass().getSimpleName(), "Failed to initialize the shader program", e);
            return;
        }

        program.setBufferAttribute(
                "aFramePosition",
                GlUtil.getNormalizedCoordinateBounds(),
                GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
        program.setBufferAttribute(
                "aTexCoords",
                GlUtil.getTextureCoordinateBounds(),
                GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
        for (String key : currentFloats.keySet()) {
            program.setFloatUniform(key, checkNotNull(currentFloats.get(key)));
        }
        for (String key : currentArrayFloats.keySet()) {
            program.setFloatsUniform(key, checkNotNull(currentArrayFloats.get(key)));
        }
        if (secondTexture != null) {
            if (vertexShader.contains("bTexCoords")) {
                program.setBufferAttribute(
                        "bTexCoords",
                        GlUtil.getTextureCoordinateBounds(),
                        GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
            }
            program.setFloatUniform(secondTexture + "Ready", 0);
            GLES20.glGenTextures(1, textures, 0);
            GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MIN_FILTER, GL10.GL_LINEAR);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MAG_FILTER, GL10.GL_LINEAR);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_S, GL10.GL_CLAMP_TO_EDGE);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_T, GL10.GL_CLAMP_TO_EDGE);
            if (secondBitmap != null) {
                GLUtils.texImage2D(GL10.GL_TEXTURE_2D, /* level= */ 0, secondBitmap, /* border= */ 0);
            }
        }
    }

    public void setFloatUniform(String name, float value) {
        if (program != null) {
            program.setFloatUniform(name, value);
        } else {
            currentFloats.put(name, value);
        }
    }

    public void setFloatsUniform(String name, float[] value) {
        if (program != null) {
            program.setFloatsUniform(name, value);
        } else {
            currentArrayFloats.put(name, value);
        }
    }

    public void setSecondBitmap(Bitmap secondBitmap) {
        this.secondBitmap = secondBitmap;
    }

    @Override
    public void setSurfaceSize(int width, int height) {
        if (eventSink != null) {
            final Map<String, Integer> result = new HashMap<>();
            result.put("width", width);
            result.put("height", height);
            mainHandler.post(() -> eventSink.success(result));
        }
        outputWith = width;
        outputHeight = height;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
        if (outputWith != -1 && outputHeight != -1) {
            final Map<String, Integer> result = new HashMap<>();
            result.put("width", outputWith);
            result.put("height", outputHeight);
            mainHandler.post(() -> eventSink.success(result));
        }
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }
    @Override
    public void draw(int frameTexture, long frameTimestampUs, float[] transformMatrix) {

        if (secondTexture != null && secondBitmap != null) {
            program.setFloatUniform(secondTexture + "Ready", 1);
            GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
            GLUtils.texImage2D(GL10.GL_TEXTURE_2D, /* level= */ 0, secondBitmap, /* border= */ 0);
            try {
                GlUtil.checkGlError();
            } catch (GlUtil.GlException e) {
                Log.e(getClass().getSimpleName(), "Failed to populate the texture", e);
            }
        }
        // Run the shader program.
        GlProgram program = checkNotNull(this.program);
        program.setSamplerTexIdUniform("inputImageTexture", frameTexture, /* texUnitIndex= */ 0);
        if (secondTexture != null) {
            program.setSamplerTexIdUniform(secondTexture, textures[0], /* texUnitIndex= */ 1);
        }
        program.setFloatsUniform("uTexTransform", transformMatrix);
        try {
            program.bindAttributesAndUniforms();
        } catch (GlUtil.GlException e) {
            Log.e(getClass().getSimpleName(), "Failed to update the shader program", e);
        }
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, /* first= */ 0, /* count= */ 4);
        try {
            GlUtil.checkGlError();
        } catch (GlUtil.GlException e) {
            Log.e(getClass().getSimpleName(), "Failed to draw a frame", e);
        }
    }

    @Override
    public void release() {
        eventSink.endOfStream();
        eventSink = null;
        outputWith = -1;
        outputHeight = -1;
        if (program != null) {
            try {
                program.delete();
            } catch (GlUtil.GlException e) {
                Log.e(getClass().getSimpleName(), "Failed to delete the shader program", e);
            }
        }
    }
}
