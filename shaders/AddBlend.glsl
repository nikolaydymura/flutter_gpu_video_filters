precision highp float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;
            
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
  lowp vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);

  mediump float r;
  if (overlay.r * sourceColor.a + sourceColor.r * overlay.a >= overlay.a * sourceColor.a) {
    r = overlay.a * sourceColor.a + overlay.r * (1.0 - sourceColor.a) + sourceColor.r * (1.0 - overlay.a);
  } else {
    r = overlay.r + sourceColor.r;
  }

  mediump float g;
  if (overlay.g * sourceColor.a + sourceColor.g * overlay.a >= overlay.a * sourceColor.a) {
    g = overlay.a * sourceColor.a + overlay.g * (1.0 - sourceColor.a) + sourceColor.g * (1.0 - overlay.a);
  } else {
    g = overlay.g + sourceColor.g;
  }

  mediump float b;
  if (overlay.b * sourceColor.a + sourceColor.b * overlay.a >= overlay.a * sourceColor.a) {
    b = overlay.a * sourceColor.a + overlay.b * (1.0 - sourceColor.a) + sourceColor.b * (1.0 - overlay.a);
  } else {
    b = overlay.b + sourceColor.b;
  }

  mediump float a = overlay.a + sourceColor.a - overlay.a * sourceColor.a;
  return vec4(r, g, b, a);
}

void main()
{
  lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

  gl_FragColor = processColor(textureColor);
}