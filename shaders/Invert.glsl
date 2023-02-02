precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;

void main() {
    lowp vec4 color = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor = vec4((1.0 - color.rgb), color.w);
}