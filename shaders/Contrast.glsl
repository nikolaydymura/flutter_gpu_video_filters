precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp float inputContrast;

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = vec4(((textureColor.rgb - vec3(0.5)) * inputContrast + vec3(0.5)), textureColor.w);
}