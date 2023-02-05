varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp vec3 shadowsShift;
uniform lowp vec3 midtonesShift;
uniform lowp vec3 highlightsShift;
uniform int preserveLuminosity;

lowp vec3 RGBToHSL(lowp vec3 color)

{
lowp vec3 hsl;
lowp float fmin = min(min(color.r, color.g), color.b);
lowp float fmax = max(max(color.r, color.g), color.b);
lowp float delta = fmax - fmin;

hsl.z = (fmax + fmin) / 2.0;

if (delta == 0.0)
{
    hsl.x = 0.0;
    hsl.y = 0.0;
} else {
    if (hsl.z < 0.5)
        hsl.y = delta / (fmax + fmin);
    else
        hsl.y = delta / (2.0 - fmax - fmin);

    lowp float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0));
    lowp float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0));
    lowp float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0));

    if (color.r == fmax)
        hsl.x = deltaB - deltaG;
    else if (color.g == fmax)
        hsl.x = (1.0 / 3.0) + deltaR - deltaB;
    else if (color.b == fmax)
        hsl.x = (2.0 / 3.0) + deltaG - deltaR;

    if (hsl.x < 0.0)
        hsl.x += 1.0;
    else if (hsl.x > 1.0)
        hsl.x -= 1.0;
}
return hsl;
}

lowp float HueToRGB(lowp float f1, lowp float f2, lowp float hue)
{
    if (hue < 0.0)
        hue += 1.0;
    else if (hue > 1.0)
        hue -= 1.0;
    lowp float res;
    if ((6.0 * hue) < 1.0)
        res = f1 + (f2 - f1) * 6.0 * hue;
    else if ((2.0 * hue) < 1.0)
        res = f2;
    else if ((3.0 * hue) < 2.0)
        res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
    else
        res = f1;
    return res;
}

lowp vec3 HSLToRGB(lowp vec3 hsl)
{
    lowp vec3 rgb;
    if (hsl.y == 0.0)
        rgb = vec3(hsl.z);
    else
    {
        lowp float f2;
        if (hsl.z < 0.5)
            f2 = hsl.z * (1.0 + hsl.y);
        else
            f2 = (hsl.z + hsl.y) - (hsl.y * hsl.z);

        lowp float f1 = 2.0 * hsl.z - f2;

        rgb.r = HueToRGB(f1, f2, hsl.x + (1.0/3.0));
        rgb.g = HueToRGB(f1, f2, hsl.x);
        rgb.b= HueToRGB(f1, f2, hsl.x - (1.0/3.0));
    }
    return rgb;
    }

lowp float RGBToL(lowp vec3 color)
{
    lowp float fmin = min(min(color.r, color.g), color.b);
    lowp float fmax = max(max(color.r, color.g), color.b);

    return (fmax + fmin) / 2.0;
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    vec3 lightness = RGBToL(textureColor.rgb);
    lowp vec3 lightness = textureColor.rgb;

    const lowp float a = 0.25;
    const lowp float b = 0.333;
    const lowp float scale = 0.7;

    lowp vec3 shadows = shadowsShift * (clamp((lightness - b) / -a + 0.5, 0.0, 1.0) * scale);
    lowp vec3 midtones = midtonesShift * (clamp((lightness - b) / a + 0.5, 0.0, 1.0) *
        clamp((lightness + b - 1.0) / -a + 0.5, 0.0, 1.0) * scale);
    lowp vec3 highlights = highlightsShift * (clamp((lightness + b - 1.0) / a + 0.5, 0.0, 1.0) * scale);
    mediump vec3 newColor = textureColor.rgb + shadows + midtones + highlights;
    newColor = clamp(newColor, 0.0, 1.0);

    if (preserveLuminosity != 0) {
        lowp vec3 newHSL = RGBToHSL(newColor);
        lowp float oldLum = RGBToL(textureColor.rgb);

        textureColor.rgb = HSLToRGB(vec3(newHSL.x, newHSL.y, oldLum));

        gl_FragColor = textureColor;
    } else {
        gl_FragColor = vec4(newColor.rgb, textureColor.w);
    }
}
