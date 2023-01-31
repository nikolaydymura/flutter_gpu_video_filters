#version 100

attribute vec4 aFramePosition;
varying vec2 textureCoordinate;
void main() {
  gl_Position = aFramePosition;
  textureCoordinate = vec2(aFramePosition.x, aFramePosition.y);
}
