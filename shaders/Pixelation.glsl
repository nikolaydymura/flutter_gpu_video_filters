precision highp float;

varying highp vec2 vTextureCoord;

uniform float inputImageWidthFactor;
uniform float inputImageHeightFactor;
uniform lowp sampler2D inputSTexture;
uniform float inputPixel;

void main()
{
    vec2 uv  = vTextureCoord.xy;
    float dx = inputPixel * inputImageWidthFactor;
    float dy = inputPixel * inputImageHeightFactor;
    vec2 coord = vec2(dx * floor(uv.x / dx), dy * floor(uv.y / dy));
    vec3 tc = texture2D(inputSTexture, coord).xyz;
    gl_FragColor = vec4(tc, 1.0);
}