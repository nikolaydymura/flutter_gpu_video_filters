precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;

const highp vec3 weight = vec3(0.2125, 0.7154, 0.0721);
void main() {
    vec4 FragColor = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor.r = dot(FragColor.rgb, vec3(.393, .769, .189));
    gl_FragColor.g = dot(FragColor.rgb, vec3(.349, .686, .168));
    gl_FragColor.b = dot(FragColor.rgb, vec3(.272, .534, .131));
}