attribute vec4 aFramePosition;

varying vec2 textureCoordinate;

void main() {
  gl_Position = aFramePosition;

  textureCoordinate = vec2(aFramePosition.x * 0.5 + 0.5, aFramePosition.y * 0.5 + 0.5);
}
