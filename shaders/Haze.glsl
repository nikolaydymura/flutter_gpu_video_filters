precision mediump float;
varying highp vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp float inputDistance;
uniform highp float inputSlope;

void main() {
    highp vec4 color = vec4(1.0);

    highp float  d = textureCoordinate.y * inputSlope  +  inputDistance;

    highp vec4 c = texture2D(inputImageTexture, textureCoordinate);
    c = (c - d * color) / (1.0 -d);
    gl_FragColor = c;// consider using premultiply(c);
}