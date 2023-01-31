precision mediump float;

varying vec2 vTextureCoord;

uniform lowp sampler2D sTexture;

// Values from \Graphics Shaders: Theory and Practice\ by Bailey and Cunningham
const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main()
{
    lowp vec4 textureColor = texture2D(sTexture, vTextureCoord);
    float luminance = dot(textureColor.rgb, W);

    gl_FragColor = vec4(vec3(luminance), textureColor.a);
}