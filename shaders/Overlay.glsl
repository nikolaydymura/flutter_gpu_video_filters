precision mediump float;
varying vec2 vTextureCoord;
uniform lowp sampler2D sTexture;
uniform lowp sampler2D oTexture;
void main() {
    lowp vec4 textureColor = texture2D(sTexture, vTextureCoord);
    lowp vec4 textureColor2 = texture2D(oTexture, vTextureCoord);

    gl_FragColor = mix(textureColor, textureColor2, textureColor2.a);
}