precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    lowp vec4 c1 = texture2D(inputImageTexture2, textureCoordinate2);
    lowp vec4 outputColor;

    outputColor.r = c1.r + sourceColor.r * sourceColor.a * (1.0 - c1.a);
    outputColor.g = c1.g + sourceColor.g * sourceColor.a * (1.0 - c1.a);
    outputColor.b = c1.b + sourceColor.b * sourceColor.a * (1.0 - c1.a);
    outputColor.a = c1.a + sourceColor.a * (1.0 - c1.a);

    return outputColor;
}

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}