precision mediump float;
uniform lowp sampler2D inputImageTexture;
varying vec2 textureCoordinate;


uniform lowp float inputTemperature;
uniform lowp float inputTint;

const lowp vec3 warmFilter = vec3(0.93, 0.54, 0.0);

const mediump mat3 RGBtoYIQ = mat3(0.299, 0.587, 0.114, 0.596, -0.274, -0.322, 0.212, -0.523, 0.311);
const mediump mat3 YIQtoRGB = mat3(1.0, 0.956, 0.621, 1.0, -0.272, -0.647, 1.0, -1.105, 1.702);

vec4 processColor(vec4 sourceColor){
    mediump vec3 yiq = RGBtoYIQ * sourceColor.rgb;//adjusting inputTint
    yiq.b = clamp(yiq.b + inputTint*0.5226*0.1, -0.5226, 0.5226);
    lowp vec3 rgb = YIQtoRGB * yiq;

    lowp vec3 processed = vec3(
    (rgb.r < 0.5 ? (2.0 * rgb.r * warmFilter.r) : (1.0 - 2.0 * (1.0 - rgb.r) * (1.0 - warmFilter.r))), //adjusting inputTemperature
    (rgb.g < 0.5 ? (2.0 * rgb.g * warmFilter.g) : (1.0 - 2.0 * (1.0 - rgb.g) * (1.0 - warmFilter.g))),
    (rgb.b < 0.5 ? (2.0 * rgb.b * warmFilter.b) : (1.0 - 2.0 * (1.0 - rgb.b) * (1.0 - warmFilter.b))));

    return vec4(mix(rgb, processed, inputTemperature), sourceColor.a);
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}