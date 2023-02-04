precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);

    return sourceColor * (overlay.a * (sourceColor / sourceColor.a) + (2.0 * overlay * (1.0 - (sourceColor / sourceColor.a)))) + overlay * (1.0 - sourceColor.a) + sourceColor * (1.0 - overlay.a);
}

void main() {
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}
