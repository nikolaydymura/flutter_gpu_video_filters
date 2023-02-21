precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp float inputBrightness;

vec4 processColor(vec4 sourceColor){
    return vec4((sourceColor.rgb + vec3(inputBrightness)), sourceColor.w);
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}