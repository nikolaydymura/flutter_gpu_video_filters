precision lowp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform vec3 inputFirstColor;
uniform vec3 inputSecondColor;

const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

vec4 processColor(vec4 sourceColor){
    float luminance = dot(sourceColor.rgb, luminanceWeighting);

    return vec4(mix(inputFirstColor.rgb, inputSecondColor.rgb, luminance), sourceColor.a);
}

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}