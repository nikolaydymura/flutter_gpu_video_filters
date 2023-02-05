precision highp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp mat4 inputColorMatrix;

uniform lowp float inputIntensity;

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 outputColor = textureColor * inputColorMatrix;

    gl_FragColor = (inputIntensity * outputColor) + ((1.0 - inputIntensity) * textureColor);
}