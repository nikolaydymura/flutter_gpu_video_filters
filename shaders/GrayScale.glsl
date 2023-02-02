precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;

const highp vec3 weight = vec3(0.2125, 0.7154, 0.0721);
void main() {
    float luminance = dot(texture2D(inputImageTexture, textureCoordinate).rgb, weight);
    gl_FragColor = vec4(vec3(luminance), 1.0);
}