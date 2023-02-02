precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp sampler2D inputOTexture;

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 textureColor2 = texture2D(inputOTexture, textureCoordinate);

    gl_FragColor = mix(textureColor, textureColor2, textureColor2.a);
}