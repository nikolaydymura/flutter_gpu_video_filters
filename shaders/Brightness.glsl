precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform lowp float inputBrightness;

void main()
{
    lowp vec4 textureColor = texture2D(inputSTexture, vTextureCoord);

    gl_FragColor = vec4((textureColor.rgb + vec3(inputBrightness)), textureColor.w);
}