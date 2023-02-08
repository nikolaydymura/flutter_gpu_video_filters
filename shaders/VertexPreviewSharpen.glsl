attribute vec4 aFramePosition;
attribute vec4 aTexCoords;
uniform mat4 uTexTransform;

uniform float inputImageWidthFactor;
uniform float inputImageHeightFactor;
uniform float inputSharpness;

varying vec2 textureCoordinate;
varying vec2 leftTextureCoordinate;
varying vec2 rightTextureCoordinate;
varying vec2 topTextureCoordinate;
varying vec2 bottomTextureCoordinate;

varying float centerMultiplier;
varying float edgeMultiplier;

void main() {
 gl_Position = aFramePosition;

 mediump vec2 widthStep = vec2(inputImageWidthFactor, 0.0);
 mediump vec2 heightStep = vec2(0.0, inputImageHeightFactor);

 textureCoordinate = (uTexTransform * aTexCoords).xy;

 textureCoordinate = textureCoordinate.xy;
 leftTextureCoordinate = textureCoordinate.xy - widthStep;
 rightTextureCoordinate = textureCoordinate.xy + widthStep;
 topTextureCoordinate = textureCoordinate.xy + heightStep;
 bottomTextureCoordinate = textureCoordinate.xy - heightStep;

 centerMultiplier = 1.0 + 4.0 * inputSharpness;
 edgeMultiplier = inputSharpness;
}
