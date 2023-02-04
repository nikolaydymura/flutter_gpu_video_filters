precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    mediump vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
    return vec4(abs(textureColor2.rgb - sourceColor.rgb), sourceColor.a);
}

void main() {
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor = processColor(textureColor);
}