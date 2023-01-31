precision mediump float;
varying highp vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform lowp float inputOpacity;

void main()
{
    lowp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);

    gl_FragColor = vec4(textureColor.rgb, textureColor.a * inputOpacity);
}