precision mediump float;

varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform lowp float inputShadows;
uniform lowp float inputHhighlights;

const mediump vec3 luminanceWeighting = vec3(0.3, 0.3, 0.3);

void main()
{
    lowp vec4 source = texture2D(inputSTexture, vTextureCoord);
    mediump float luminance = dot(source.rgb, luminanceWeighting);

    mediump float shadow = clamp((pow(luminance, 1.0/(inputShadows+1.0)) + (-0.76)*pow(luminance, 2.0/(inputShadows+1.0))) - luminance, 0.0, 1.0);
    mediump float highlight = clamp((1.0 - (pow(1.0-luminance, 1.0/(2.0-inputHhighlights)) + (-0.8)*pow(1.0-luminance, 2.0/(2.0-inputHhighlights)))) - luminance, -1.0, 0.0);
    lowp vec3 result = vec3(0.0, 0.0, 0.0) + ((luminance + shadow + highlight) - 0.0) * ((source.rgb - vec3(0.0, 0.0, 0.0))/(luminance - 0.0));

    gl_FragColor = vec4(result.rgb, source.a);
}