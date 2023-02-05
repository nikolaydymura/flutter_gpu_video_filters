varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform mediump vec3 levelMinimum;
uniform mediump vec3 levelMiddle;
uniform mediump vec3 levelMaximum;
uniform mediump vec3 minOutput;
uniform mediump vec3 maxOutput;

void main()
{
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    gl_FragColor = vec4( mix(minOutput, maxOutput, pow(min(max(textureColor.rgb - levelMinimum, vec3(0.0)) / (levelMaximum - levelMinimum  ), vec3(1.0)), 1.0 /levelMiddle)) , textureColor.a);
}