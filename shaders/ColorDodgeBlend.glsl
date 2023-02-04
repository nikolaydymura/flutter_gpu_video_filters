precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);

    vec3 baseOverlayAlphaProduct = vec3(overlay.a * sourceColor.a);
    vec3 rightHandProduct = overlay.rgb * (1.0 - sourceColor.a) + sourceColor.rgb * (1.0 - overlay.a);

    vec3 firstBlendColor = baseOverlayAlphaProduct + rightHandProduct;
    vec3 overlayRGB = clamp((overlay.rgb / clamp(overlay.a, 0.01, 1.0)) * step(0.0, overlay.a), 0.0, 0.99);

    vec3 secondBlendColor = (sourceColor.rgb * overlay.a) / (1.0 - overlayRGB) + rightHandProduct;

    vec3 colorChoice = step((overlay.rgb * sourceColor.a + sourceColor.rgb * overlay.a), baseOverlayAlphaProduct);

    return vec4(mix(firstBlendColor, secondBlendColor, colorChoice), 1.0);
}

void main() {
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}