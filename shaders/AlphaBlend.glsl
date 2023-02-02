precision highp float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

uniform lowp float inputMixturePercent;

vec4 processColor(vec4 sourceColor) {
     lowp vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
     return vec4(mix(sourceColor.rgb, textureColor2.rgb, textureColor2.a * inputMixturePercent), sourceColor.a);
}
void main() {
  lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

  gl_FragColor = processColor(textureColor);
}