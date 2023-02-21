precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

vec4 processColor(vec4 sourceColor){
    float luminance = dot(sourceColor.rgb, luminanceWeighting);

    return vec4(vec3(luminance), sourceColor.a);
}

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}