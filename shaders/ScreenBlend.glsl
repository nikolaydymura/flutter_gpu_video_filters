precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    mediump vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);

    mediump vec4 whiteColor = vec4(1.0);

    return whiteColor - ((whiteColor - textureColor2) * (whiteColor - sourceColor));
}

void main() {
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}