precision highp float;

uniform lowp sampler2D inputSTexture;

varying vec2 textureCoordinate;
varying vec2 leftTextureCoordinate;
varying vec2 rightTextureCoordinate;

varying vec2 topTextureCoordinate;
varying vec2 topLeftTextureCoordinate;
varying vec2 topRightTextureCoordinate;

varying vec2 bottomTextureCoordinate;
varying vec2 bottomLeftTextureCoordinate;
varying vec2 bottomRightTextureCoordinate;

//			uniform highp float intensity;
uniform highp float inputThreshold;
uniform highp float inputQuantizationLevels;

const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main() {
    vec4 textureColor = texture2D(inputSTexture, textureCoordinate);

    float bottomLeftIntensity = texture2D(inputSTexture, bottomLeftTextureCoordinate).r;
    float topRightIntensity = texture2D(inputSTexture, topRightTextureCoordinate).r;
    float topLeftIntensity = texture2D(inputSTexture, topLeftTextureCoordinate).r;
    float bottomRightIntensity = texture2D(inputSTexture, bottomRightTextureCoordinate).r;
    float leftIntensity = texture2D(inputSTexture, leftTextureCoordinate).r;
    float rightIntensity = texture2D(inputSTexture, rightTextureCoordinate).r;
    float bottomIntensity = texture2D(inputSTexture, bottomTextureCoordinate).r;
    float topIntensity = texture2D(inputSTexture, topTextureCoordinate).r;
    float h = -topLeftIntensity - 2.0 * topIntensity - topRightIntensity + bottomLeftIntensity + 2.0 * bottomIntensity + bottomRightIntensity;
    float v = -bottomLeftIntensity - 2.0 * leftIntensity - topLeftIntensity + bottomRightIntensity + 2.0 * rightIntensity + topRightIntensity;

    float mag = length(vec2(h, v));
    vec3 posterizedImageColor = floor((textureColor.rgb * inputQuantizationLevels) + 0.5) / inputQuantizationLevels;
    float inputThresholdTest = 1.0 - step(inputThreshold, mag);
    gl_FragColor = vec4(posterizedImageColor * inputThresholdTest, textureColor.a);
}