precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform highp float inputColorLevels;

void main()
{
    highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = floor((textureColor * inputColorLevels) + vec4(0.5)) / inputColorLevels;
}