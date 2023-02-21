precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp float inputGamma;

vec4 processColor(vec4 sourceColor){
     return vec4(pow(sourceColor.rgb, vec3(inputGamma)), sourceColor.w);
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}