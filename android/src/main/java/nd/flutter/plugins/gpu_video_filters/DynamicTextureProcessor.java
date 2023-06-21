package nd.flutter.plugins.gpu_video_filters;

import static com.google.android.exoplayer2.util.Assertions.checkNotNull;
import static com.google.android.exoplayer2.util.Assertions.checkStateNotNull;

import android.graphics.Bitmap;
import android.opengl.GLES20;
import android.opengl.GLUtils;
import android.util.Pair;

import com.google.android.exoplayer2.util.FrameProcessingException;
import com.google.android.exoplayer2.effect.SingleFrameGlTextureProcessor;
import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;

import java.util.HashMap;
import java.util.Map;

import javax.microedition.khronos.opengles.GL10;

class DynamicTextureEffect extends SingleFrameGlTextureProcessor {
    GlProgram glProgram;
    private final int[] textures;
    private final String secondTexture;
    private final Bitmap secondBitmap;
    public DynamicTextureEffect(String vertexShader, String fragmentShader,
                                String secondTexture,
                                Bitmap secondBitmap,
                                Map<String, Float> currentFloats,
                                Map<String, float[]> currentArrayFloats,
                                boolean useHdr) throws FrameProcessingException {
        super(useHdr);
        this.secondBitmap = secondBitmap;
        this.secondTexture = secondTexture;
        this.textures = new int[secondTexture != null ? 1 : 0];
        try {
            glProgram = new GlProgram(vertexShader, fragmentShader);;
        } catch (GlUtil.GlException e) {
            throw new FrameProcessingException(e);
        }
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

    @Override
    public Pair<Integer, Integer> configure(int inputWidth, int inputHeight) {
        return Pair.create(inputWidth, inputHeight);
    }

    @Override
    public void drawFrame(int inputTexId, long presentationTimeUs) throws FrameProcessingException {
        try {
            if (secondTexture != null && secondBitmap != null) {
                GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
                GLUtils.texImage2D(GL10.GL_TEXTURE_2D, /* level= */ 0, secondBitmap, /* border= */ 0);
                GlUtil.checkGlError();
            }
            checkStateNotNull(glProgram).use();

            GlUtil.checkGlError();
            glProgram.setSamplerTexIdUniform("inputImageTexture", inputTexId, /* texUnitIndex= */ 0);
            if (secondTexture != null) {
                glProgram.setSamplerTexIdUniform(secondTexture, textures[0], /* texUnitIndex= */ 1);
            }
            glProgram.bindAttributesAndUniforms();
            // The four-vertex triangle strip forms a quad.
            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, /* first= */ 0, /* count= */ 4);
            GlUtil.checkGlError();
        } catch (GlUtil.GlException e) {
            System.err.println(e);
            throw new FrameProcessingException(e, presentationTimeUs);
        }
    }

    @Override
    public void release() throws FrameProcessingException {
        super.release();
        try {
            glProgram.delete();
        } catch (GlUtil.GlException e) {
            throw new FrameProcessingException(e);
        }
    }
}

public class DynamicTextureProcessor {
    private final String vertexShader;
    private final String fragmentShader;
    private final String secondTexture;
    private Bitmap secondBitmap;
    public OnUniformsUpdater onUniformsUpdater;

    private DynamicTextureEffect textureEffect;
    DynamicTextureProcessor(
            String vertexShader, String fragmentShader,
            Map<String, Float> fragmentDefaultFloats,
            Map<String, float[]> fragmentDefaultArrayFloats,
            String secondTexture) {
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        this.secondTexture = secondTexture;
        for (String key : fragmentDefaultFloats.keySet()) {
            currentFloats.put(key, fragmentDefaultFloats.get(key));
        }
        for (String key : fragmentDefaultArrayFloats.keySet()) {
            float[] values = checkNotNull(fragmentDefaultArrayFloats.get(key));
            currentArrayFloats.put(key, values);
        }
    }

    DynamicTextureEffect create(boolean useHdr) throws FrameProcessingException {
        if (textureEffect == null) {
            textureEffect = new DynamicTextureEffect(vertexShader, fragmentShader, secondTexture, secondBitmap, currentFloats, currentArrayFloats, useHdr);
        }
        return textureEffect;
    }

    private final Map<String, Float> currentFloats = new HashMap<>();
    private final Map<String, float[]> currentArrayFloats = new HashMap<>();

    public void setFloatUniform(String name, float value) {
        if (textureEffect != null && textureEffect.glProgram != null) {
            textureEffect.glProgram.setFloatUniform(name, value);
        } else {
            currentFloats.put(name, value);
        }
        if (onUniformsUpdater != null) {
            onUniformsUpdater.setFloatUniform(name, value);
        }
    }

    public void setFloatsUniform(String name, float[] value) {
        if (textureEffect != null && textureEffect.glProgram != null) {
            textureEffect.glProgram.setFloatsUniform(name, value);
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

    public void dispose() throws FrameProcessingException {
        if (textureEffect != null) {
            textureEffect.release();
        }
    }
}
