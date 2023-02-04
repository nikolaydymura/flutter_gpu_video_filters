precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
    mediump float ra;
    if (2.0 * sourceColor.r < sourceColor.a) {
        ra = 2.0 * overlay.r * sourceColor.r + overlay.r * (1.0 - sourceColor.a) + sourceColor.r * (1.0 - overlay.a);
    } else {
        ra = overlay.a * sourceColor.a - 2.0 * (sourceColor.a - sourceColor.r) * (overlay.a - overlay.r) + overlay.r * (1.0 - sourceColor.a) + sourceColor.r * (1.0 - overlay.a);
    }
    mediump float ga;
    if (2.0 * sourceColor.g < sourceColor.a) {
        ga = 2.0 * overlay.g * sourceColor.g + overlay.g * (1.0 - sourceColor.a) + sourceColor.g * (1.0 - overlay.a);
    } else {
        ga = overlay.a * sourceColor.a - 2.0 * (sourceColor.a - sourceColor.g) * (overlay.a - overlay.g) + overlay.g * (1.0 - sourceColor.a) + sourceColor.g * (1.0 - overlay.a);
    }
    mediump float ba;
    if (2.0 * sourceColor.b < sourceColor.a) {
        ba = 2.0 * overlay.b * sourceColor.b + overlay.b * (1.0 - sourceColor.a) + sourceColor.b * (1.0 - overlay.a);
    } else {
        ba = overlay.a * sourceColor.a - 2.0 * (sourceColor.a - sourceColor.b) * (overlay.a - overlay.b) + overlay.b * (1.0 - sourceColor.a) + sourceColor.b * (1.0 - overlay.a);
    }

    return vec4(ra, ga, ba, 1.0);
}

void main() {
    mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}