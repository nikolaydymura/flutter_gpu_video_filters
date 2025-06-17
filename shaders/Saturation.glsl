precision mediump float;
varying vec2 textureCoordinate;
 
uniform lowp sampler2D inputImageTexture;
uniform lowp float inputSaturation;
 
const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

vec4 processColor(vec4 sourceColor){
    lowp float luminance = dot(sourceColor.rgb, luminanceWeighting);
    lowp vec3 greyScaleColor = vec3(luminance);

    return vec4(mix(greyScaleColor, sourceColor.rgb, inputSaturation), sourceColor.w);
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}