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

import android.graphics.Canvas;
import android.opengl.GLES20;

import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * Video processor that demonstrates how to overlay a bitmap on video output using a GL shader. The
 * bitmap is drawn using an Android {@link Canvas}.
 */
/* package */ final class DynamicVideoProcessor
        implements VideoProcessingGLSurfaceView.VideoProcessor {

    private final String vertexShader;
    private final String fragmentShader;
    private final Map<String, Float> currentFloats = new HashMap<>();
    private final Map<String, float[]> currentArrayFloats = new HashMap<>();
    private GlProgram program;

    public DynamicVideoProcessor(String vertexShader, String fragmentShader, Map<String, Float> fragmentDefaultFloats, Map<String, float[]> fragmentDefaultArrayFloats) {
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        for (String key : fragmentDefaultFloats.keySet()) {
            currentFloats.put(key, checkNotNull(fragmentDefaultFloats.get(key)));
        }
        for (String key : fragmentDefaultArrayFloats.keySet()) {
            float[] values = checkNotNull(fragmentDefaultArrayFloats.get(key));
            currentArrayFloats.put(key, values);
        }
    }

    @Override
    public void initialize() {
        program = new GlProgram(vertexShader, fragmentShader);
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
    @Override
    public void setSurfaceSize(int width, int height) {
    }

    @Override
    public void draw(int frameTexture, long frameTimestampUs, float[] transformMatrix) {

        // Run the shader program.
        GlProgram program = checkNotNull(this.program);
        program.setSamplerTexIdUniform("inputImageTexture", frameTexture, /* texUnitIndex= */ 0);
        program.setFloatsUniform("uTexTransform", transformMatrix);
        program.bindAttributesAndUniforms();
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, /* first= */ 0, /* count= */ 4);
        GlUtil.checkGlError();
    }

    @Override
    public void release() {
        if (program != null) {
            program.delete();
        }
    }
}
