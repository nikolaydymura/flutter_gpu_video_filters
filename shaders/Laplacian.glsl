precision highp float;

uniform sampler2D inputImageTexture;

uniform mediump mat3 inputConvolutionMatrix;

varying vec2 textureCoordinate;
varying vec2 leftTextureCoordinate;
varying vec2 rightTextureCoordinate;

varying vec2 topTextureCoordinate;
varying vec2 topLeftTextureCoordinate;
varying vec2 topRightTextureCoordinate;

varying vec2 bottomTextureCoordinate;
varying vec2 bottomLeftTextureCoordinate;
varying vec2 bottomRightTextureCoordinate;

void main()
{
   mediump vec3 bottomColor = texture2D(inputImageTexture, bottomTextureCoordinate).rgb;
   mediump vec3 bottomLeftColor = texture2D(inputImageTexture, bottomLeftTextureCoordinate).rgb;
   mediump vec3 bottomRightColor = texture2D(inputImageTexture, bottomRightTextureCoordinate).rgb;
   mediump vec4 centerColor = texture2D(inputImageTexture, textureCoordinate);
   mediump vec3 leftColor = texture2D(inputImageTexture, leftTextureCoordinate).rgb;
   mediump vec3 rightColor = texture2D(inputImageTexture, rightTextureCoordinate).rgb;
   mediump vec3 topColor = texture2D(inputImageTexture, topTextureCoordinate).rgb;
   mediump vec3 topRightColor = texture2D(inputImageTexture, topRightTextureCoordinate).rgb;
   mediump vec3 topLeftColor = texture2D(inputImageTexture, topLeftTextureCoordinate).rgb;

  mediump vec3 resultColor = topLeftColor * inputConvolutionMatrix[0][0] + topColor * inputConvolutionMatrix[0][1] + topRightColor * inputConvolutionMatrix[0][2];
  resultColor += leftColor * inputConvolutionMatrix[1][0] + centerColor.rgb * inputConvolutionMatrix[1][1] + rightColor * inputConvolutionMatrix[1][2];
  resultColor += bottomLeftColor * inputConvolutionMatrix[2][0] + bottomColor * inputConvolutionMatrix[2][1] + bottomRightColor * inputConvolutionMatrix[2][2];

  resultColor = resultColor + 0.5;

  gl_FragColor = vec4(resultColor, centerColor.a);
}