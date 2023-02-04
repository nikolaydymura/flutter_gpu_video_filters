precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);

    //     Dca = (Sca.Da + Dca.Sa - 2.Sca.Dca) + Sca.(1 - Da) + Dca.(1 - Sa)

    return vec4((overlay.rgb * sourceColor.a + sourceColor.rgb * overlay.a - 2.0 * overlay.rgb * sourceColor.rgb) + overlay.rgb * (1.0 - sourceColor.a) + sourceColor.rgb * (1.0 - overlay.a), sourceColor.a);
}

void main() {
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}