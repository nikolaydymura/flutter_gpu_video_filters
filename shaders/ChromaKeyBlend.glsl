precision highp float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;
            
uniform float inputThresholdSensitivity;
uniform float inputSmoothing;
uniform vec3 inputColorToReplace;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);

    float maskY = 0.2989 * inputColorToReplace.r + 0.5866 * inputColorToReplace.g + 0.1145 * inputColorToReplace.b;
    float maskCr = 0.7132 * (inputColorToReplace.r - maskY);
    float maskCb = 0.5647 * (inputColorToReplace.b - maskY);

    float Y = 0.2989 * sourceColor.r + 0.5866 * sourceColor.g + 0.1145 * sourceColor.b;
    float Cr = 0.7132 * (sourceColor.r - Y);
    float Cb = 0.5647 * (sourceColor.b - Y);

    float blendValue = 1.0 - smoothstep(inputThresholdSensitivity, inputThresholdSensitivity + inputSmoothing, distance(vec2(Cr, Cb), vec2(maskCr, maskCb)));
    return mix(sourceColor, textureColor2, blendValue);
}

void main()
{
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}