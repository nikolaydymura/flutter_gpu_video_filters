precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform lowp sampler2D inputOTexture;

void main() {
    lowp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);
    lowp vec4 textureColor2 = texture2D(inputOTexture, vTextureCoord);

    gl_FragColor = mix(textureColor, textureColor2, textureColor2.a);
}