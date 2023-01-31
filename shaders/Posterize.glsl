precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform highp float inputColorLevels;

void main()
{
    highp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);

    gl_FragColor = floor((textureColor * inputColorLevels) + vec4(0.5)) / inputColorLevels;
}