precision highp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;

vec4 processColor(vec4 sourceColor){
    return vec4((1.0 - sourceColor.rgb), sourceColor.w);
}

void main() {
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}