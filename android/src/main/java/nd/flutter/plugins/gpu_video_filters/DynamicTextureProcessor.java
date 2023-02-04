package nd.flutter.plugins.gpu_video_filters;

import static com.google.android.exoplayer2.util.Assertions.checkNotNull;
import static com.google.android.exoplayer2.util.Assertions.checkStateNotNull;

import android.content.Context;
import android.graphics.Bitmap;
import android.opengl.GLES20;
import android.opengl.GLUtils;
import android.util.Size;

import com.google.android.exoplayer2.transformer.FrameProcessingException;
import com.google.android.exoplayer2.transformer.SingleFrameGlTextureProcessor;
import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;

import java.util.HashMap;
import java.util.Map;

import javax.microedition.khronos.opengles.GL10;

public class DynamicTextureProcessor implements SingleFrameGlTextureProcessor {
    static {
        GlUtil.glAssertionsEnabled = true;
    }
    private final String vertexShader;
    private final String fragmentShader;

    private Size outputSize;
    private GlProgram glProgram;

    private final Map<String, Float> currentFloats = new HashMap<>();
    private final Map<String, float[]> currentArrayFloats = new HashMap<>();
    private final int[] textures;
    private final String secondTexture;
    private Bitmap secondBitmap;
    public OnUniformsUpdater onUniformsUpdater;

    public DynamicTextureProcessor(String vertexShader, String fragmentShader,
                                   Map<String, Float> fragmentDefaultFloats,
                                   Map<String, float[]> fragmentDefaultArrayFloats,
                                   String secondTexture) {
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        for (String key : fragmentDefaultFloats.keySet()) {
            currentFloats.put(key, fragmentDefaultFloats.get(key));
        }
        for (String key : fragmentDefaultArrayFloats.keySet()) {
            float[] values = checkNotNull(fragmentDefaultArrayFloats.get(key));
            currentArrayFloats.put(key, values);
        }
        this.secondTexture = secondTexture;
        this.textures = new int[secondTexture != null ? 1 : 0];
    }

    @Override
    public void initialize(Context context, int inputTexId, int inputWidth, int inputHeight) {
        outputSize = new Size(inputWidth, inputHeight);

        glProgram = new GlProgram(vertexShader, fragmentShader);
        // Draw the frame on the entire normalized device coordinate space, from -1 to 1, for x and y.
        glProgram.setBufferAttribute(
                "aFramePosition",
                GlUtil.getNormalizedCoordinateBounds(),
                GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
        for (String key : currentFloats.keySet()) {
            glProgram.setFloatUniform(key, checkNotNull(currentFloats.get(key)));
        }
        for (String key : currentArrayFloats.keySet()) {
            glProgram.setFloatsUniform(key, checkNotNull(currentArrayFloats.get(key)));
        }
        glProgram.setSamplerTexIdUniform("inputImageTexture", inputTexId, /* texUnitIndex= */ 0);

        if (secondTexture != null) {
            if (vertexShader.contains("aTexCoords")) {
                glProgram.setBufferAttribute(
                        "aTexCoords",
                        GlUtil.getTextureCoordinateBounds(),
                        GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
            }
            GLES20.glGenTextures(1, textures, 0);
            GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MIN_FILTER, GL10.GL_NEAREST);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MAG_FILTER, GL10.GL_LINEAR);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_S, GL10.GL_REPEAT);
            GLES20.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_T, GL10.GL_REPEAT);
            if (secondBitmap != null) {
                GLUtils.texImage2D(GL10.GL_TEXTURE_2D, /* level= */ 0, secondBitmap, /* border= */ 0);
            }
        }
    }

    public void setFloatUniform(String name, float value) {
        if (glProgram != null) {
            glProgram.setFloatUniform(name, value);
        } else {
            currentFloats.put(name, value);
        }
        if (onUniformsUpdater != null) {
            onUniformsUpdater.setFloatUniform(name, value);
        }
    }

    public void setFloatsUniform(String name, float[] value) {
        if (glProgram != null) {
            glProgram.setFloatsUniform(name, value);
        } else {
            currentArrayFloats.put(name, value);
        }
        if (onUniformsUpdater != null) {
            onUniformsUpdater.setFloatsUniform(name, value);
        }
    }

    public void setBitmap(String name, Bitmap value) {
        this.secondBitmap = value;
        if (onUniformsUpdater != null) {
            onUniformsUpdater.setBitmapUniform(name, value);
        }
    }

    @Override
    public Size getOutputSize() {
        return checkStateNotNull(outputSize);
    }

    @Override
    public void drawFrame(long presentationTimeUs) throws FrameProcessingException {
        try {
            if (secondTexture != null && secondBitmap != null) {
                GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
                GLUtils.texImage2D(GL10.GL_TEXTURE_2D, /* level= */ 0, secondBitmap, /* border= */ 0);
                GlUtil.checkGlError();
            }
            checkStateNotNull(glProgram).use();

            GlUtil.checkGlError();
            if (secondTexture != null) {
                glProgram.setSamplerTexIdUniform(secondTexture, textures[0], /* texUnitIndex= */ 1);
            }
            glProgram.bindAttributesAndUniforms();
            // The four-vertex triangle strip forms a quad.
            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, /* first= */ 0, /* count= */ 4);
            GlUtil.checkGlError();
        } catch (GlUtil.GlException e) {
            throw new FrameProcessingException(e);
        }
    }

    @Override
    public void release() {
        if (glProgram != null) {
            glProgram.delete();
        }
    }
}
