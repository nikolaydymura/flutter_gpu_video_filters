precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform highp float inputRed;
uniform highp float inputGreen;
uniform highp float inputBlue;

void main()
{
    highp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);

    gl_FragColor = vec4(textureColor.r * inputRed, textureColor.g * inputGreen, textureColor.b * inputBlue, 1.0);
}