package nd.flutter.plugins.gpu_video_filters;

import static com.google.android.exoplayer2.util.Assertions.checkStateNotNull;

import android.content.Context;
import android.opengl.GLES20;
import android.util.Size;

import com.google.android.exoplayer2.transformer.FrameProcessingException;
import com.google.android.exoplayer2.transformer.SingleFrameGlTextureProcessor;
import com.google.android.exoplayer2.util.GlProgram;
import com.google.android.exoplayer2.util.GlUtil;

import java.io.IOException;

public class DynamicProcessor implements SingleFrameGlTextureProcessor {
    static {
        GlUtil.glAssertionsEnabled = true;
    }

    private static final String VERTEX_SHADER_PATH = "vertex_shader_copy_es2.glsl";
    private final String fragmentShader;

    private Size outputSize;
    private GlProgram glProgram;

    public DynamicProcessor(String fragmentShader) {
        this.fragmentShader = fragmentShader;
    }

    @Override
    public void initialize(Context context, int inputTexId, int inputWidth, int inputHeight)
            throws IOException {
        outputSize = new Size(inputWidth, inputHeight);

        glProgram = new GlProgram(context, VERTEX_SHADER_PATH, fragmentShader);
        // Draw the frame on the entire normalized device coordinate space, from -1 to 1, for x and y.
        glProgram.setBufferAttribute(
                "aFramePosition",
                GlUtil.getNormalizedCoordinateBounds(),
                GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE);
        glProgram.setSamplerTexIdUniform("uTexSampler0", inputTexId, /* texUnitIndex= */ 0);
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
