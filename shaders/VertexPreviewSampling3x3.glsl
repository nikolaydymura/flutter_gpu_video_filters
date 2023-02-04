attribute vec4 aFramePosition;
attribute vec4 aTexCoords;

uniform mat4 uTexTransform;
uniform highp float inputTexelWidth;
uniform highp float inputTexelHeight;

varying highp vec2 textureCoordinate;
varying highp vec2 leftTextureCoordinate;
varying highp vec2 rightTextureCoordinate;

varying highp vec2 topTextureCoordinate;
varying highp vec2 topLeftTextureCoordinate;
varying highp vec2 topRightTextureCoordinate;

varying highp vec2 bottomTextureCoordinate;
varying highp vec2 bottomLeftTextureCoordinate;
varying highp vec2 bottomRightTextureCoordinate;

void main() {
    gl_Position = aFramePosition;

    vec2 widthStep = vec2(inputTexelWidth, 0.0);
    vec2 heightStep = vec2(0.0, inputTexelHeight);
    vec2 widthHeightStep = vec2(inputTexelWidth, inputTexelHeight);
    vec2 widthNegativeHeightStep = vec2(inputTexelWidth, -inputTexelHeight);

    textureCoordinate = (uTexTransform * aTexCoords).xy;
    leftTextureCoordinate = textureCoordinate - widthStep;
    rightTextureCoordinate = textureCoordinate + widthStep;

    topTextureCoordinate = textureCoordinate - heightStep;
    topLeftTextureCoordinate = textureCoordinate - widthHeightStep;
    topRightTextureCoordinate = textureCoordinate + widthNegativeHeightStep;

    bottomTextureCoordinate = textureCoordinate + heightStep;
    bottomLeftTextureCoordinate = textureCoordinate - widthNegativeHeightStep;
    bottomRightTextureCoordinate = textureCoordinate + widthHeightStep;
}