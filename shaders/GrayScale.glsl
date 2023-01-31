precision mediump float;
varying vec2 vTextureCoord;
uniform lowp sampler2D sTexture;
const highp vec3 weight = vec3(0.2125, 0.7154, 0.0721);
void main() {
float luminance = dot(texture2D(sTexture, vTextureCoord).rgb, weight);
gl_FragColor = vec4(vec3(luminance), 1.0);
}