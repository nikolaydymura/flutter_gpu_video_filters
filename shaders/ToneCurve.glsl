precision highp float;

varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform sampler2D inputTextureToneCurve;

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp float redCurveValue = texture2D(inputTextureToneCurve, vec2(textureColor.r, 0.0)).r;
    lowp float greenCurveValue = texture2D(inputTextureToneCurve, vec2(textureColor.g, 0.0)).g;
    lowp float blueCurveValue = texture2D(inputTextureToneCurve, vec2(textureColor.b, 0.0)).b;

    gl_FragColor = vec4(redCurveValue, greenCurveValue, blueCurveValue, textureColor.a);
}