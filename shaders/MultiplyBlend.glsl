precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    lowp vec4 overlayer = texture2D(inputImageTexture2, textureCoordinate2);

    return overlayer * sourceColor + overlayer * (1.0 - sourceColor.a) + sourceColor * (1.0 - overlayer.a);
}

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}