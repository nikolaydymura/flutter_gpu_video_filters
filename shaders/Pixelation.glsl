precision highp float;

varying highp vec2 textureCoordinate;

uniform float inputImageWidthFactor;
uniform float inputImageHeightFactor;
uniform lowp sampler2D inputImageTexture;
uniform float inputPixel;

void main()
{
    vec2 uv  = textureCoordinate.xy;
    float dx = inputPixel * inputImageWidthFactor;
    float dy = inputPixel * inputImageHeightFactor;
    vec2 coord = vec2(dx * floor(uv.x / dx), dy * floor(uv.y / dy));
    vec3 tc = texture2D(inputImageTexture, coord).xyz;
    gl_FragColor = vec4(tc, 1.0);
}