precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inoutSTexture;
uniform lowp float inoutGamma;

void main()
{
    lowp vec4 textureColor = texture2D(inoutSTexture, vTextureCoord);

    gl_FragColor = vec4(pow(textureColor.rgb, vec3(inoutGamma)), textureColor.w);
}