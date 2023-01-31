precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform highp float inputExposure;

void main()
{
    highp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);

    gl_FragColor = vec4(textureColor.rgb * pow(2.0, inputExposure), textureColor.w);
}