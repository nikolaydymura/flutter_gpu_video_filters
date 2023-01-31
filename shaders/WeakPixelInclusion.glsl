precision lowp float;

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

void main() {
    float bottomLeftIntensity = texture2D(inputSTexture, bottomLeftTextureCoordinate).r;
    float topRightIntensity = texture2D(inputSTexture, topRightTextureCoordinate).r;
    float topLeftIntensity = texture2D(inputSTexture, topLeftTextureCoordinate).r;
    float bottomRightIntensity = texture2D(inputSTexture, bottomRightTextureCoordinate).r;
    float leftIntensity = texture2D(inputSTexture, leftTextureCoordinate).r;
    float rightIntensity = texture2D(inputSTexture, rightTextureCoordinate).r;
    float bottomIntensity = texture2D(inputSTexture, bottomTextureCoordinate).r;
    float topIntensity = texture2D(inputSTexture, topTextureCoordinate).r;
    float centerIntensity = texture2D(inputSTexture, textureCoordinate).r;

    float pixelIntensitySum = bottomLeftIntensity + topRightIntensity + topLeftIntensity + bottomRightIntensity + leftIntensity + rightIntensity + bottomIntensity + topIntensity + centerIntensity;
    float sumTest = step(1.5, pixelIntensitySum);
    float pixelTest = step(0.01, centerIntensity);

    gl_FragColor = vec4(vec3(sumTest * pixelTest), 1.0);
}