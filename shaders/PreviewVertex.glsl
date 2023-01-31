attribute vec4 aFramePosition;
attribute vec4 aTexCoords;
uniform mat4 uTexTransform;
varying vec2 textureCoordinate;
void main() {
 gl_Position = aFramePosition;
 textureCoordinate = (uTexTransform * aTexCoords).xy;
}
