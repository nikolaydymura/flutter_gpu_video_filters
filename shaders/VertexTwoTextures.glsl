attribute vec4 aFramePosition;

attribute vec4 aTexCoords;

varying vec2 textureCoordinate;
varying vec2 textureCoordinate2;

void main() {
 gl_Position = aFramePosition;
 textureCoordinate = vec2(aFramePosition.x * 0.5 + 0.5, aFramePosition.y * 0.5 + 0.5);
 textureCoordinate2 = aTexCoords.xy;

}
