package nd.flutter.plugins.gpu_video_filters;

import static com.google.android.exoplayer2.util.Assertions.checkStateNotNull;

import android.content.Context;
import android.opengl.GLES20;
import android.util.Size;

import com.google.android.exoplayer2.transformer.FrameProcessingException;
import com.google.android.exoplayer2.transformer.SingleFrameGlTextureProcessor;
import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;

import java.util.HashMap;
import java.util.Map;
public class DynamicTextureProcessor implements SingleFrameGlTextureProcessor {
    static {
        GlUtil.glAssertionsEnabled = true;
    }
    private final String vertexShader;
    private final String fragmentShader;

    private Size outputSize;
    private GlProgram glProgram;

    private final Map<String, Float> currentFloats = new HashMap<>();

    public OnUniformsUpdater onUniformsUpdater;

    public DynamicTextureProcessor(String vertexShader, String fragmentShader, Map<String, Double> fragmentDefaultFloats) {
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        for (String key : fragmentDefaultFloats.keySet()) {
            currentFloats.put(key, fragmentDefaultFloats.get(key).floatValue());
        }
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
            glProgram.setFloatUniform(key, currentFloats.get(key));
        }
        glProgram.setSamplerTexIdUniform("inputImageTexture", inputTexId, /* texUnitIndex= */ 0);
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
        if (onUniformsUpdater != null) {
            onUniformsUpdater.setFloatsUniform(name, value);
        }
    }

    @Override
    public Size getOutputSize() {
        return checkStateNotNull(outputSize);
    }

    @Override
    public void drawFrame(long presentationTimeUs) throws FrameProcessingException {
        try {
            checkStateNotNull(glProgram).use();

            GlUtil.checkGlError();

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
