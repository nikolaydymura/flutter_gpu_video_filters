attribute vec4 aFramePosition;
attribute vec4 aTexCoords;
attribute vec4 bTexCoords;
uniform mat4 uTexTransform;
varying vec2 textureCoordinate;
varying vec2 textureCoordinate2;
void main() {
 gl_Position = aFramePosition;
 textureCoordinate = (uTexTransform * aTexCoords).xy;
 textureCoordinate2 = (uTexTransform * bTexCoords).xy;
}
