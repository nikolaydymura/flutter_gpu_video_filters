precision mediump float;
varying vec2 vTextureCoord;

uniform lowp sampler2D inputSTexture;
uniform lowp float inputVibrance;

void main() {
    lowp vec4 color = texture2D(inputSTexture, vTextureCoord);
    lowp float average = (color.r + color.g + color.b) / 3.0;
    lowp float mx = max(color.r, max(color.g, color.b));
    lowp float amt = (mx - average) * (-inputVibrance * 3.0);
    color.rgb = mix(color.rgb, vec3(mx), amt);
    gl_FragColor = color;
}