precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform highp float inputCrossHatchSpacing;
uniform highp float inputLineWidth;

const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main()
{
    highp float luminance = dot(texture2D(inputSTexture, vTextureCoord).rgb, W);
    lowp vec4 colorToDisplay = vec4(1.0, 1.0, 1.0, 1.0);
    if (luminance < 1.00)
    {
        if (mod(vTextureCoord.x + vTextureCoord.y, inputCrossHatchSpacing) <= inputLineWidth)
        {
            colorToDisplay = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
    if (luminance < 0.75)
    {
        if (mod(vTextureCoord.x - vTextureCoord.y, inputCrossHatchSpacing) <= inputLineWidth)
        {
            colorToDisplay = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
    if (luminance < 0.50)
    {
        if (mod(vTextureCoord.x + vTextureCoord.y - (inputCrossHatchSpacing / 2.0), inputCrossHatchSpacing) <= inputLineWidth)
        {
            colorToDisplay = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
    if (luminance < 0.3)
    {
        if (mod(vTextureCoord.x - vTextureCoord.y - (inputCrossHatchSpacing / 2.0), inputCrossHatchSpacing) <= inputLineWidth)
        {
            colorToDisplay = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
    gl_FragColor = colorToDisplay;
}