precision mediump float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
  mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);

  mediump float ra;
  if (overlay.a == 0.0 || ((sourceColor.r / overlay.r) > (sourceColor.a / overlay.a))) {
    ra = overlay.a * sourceColor.a + overlay.r * (1.0 - sourceColor.a) + sourceColor.r * (1.0 - overlay.a);
  } else {
    ra = (sourceColor.r * overlay.a * overlay.a) / overlay.r + overlay.r * (1.0 - sourceColor.a) + sourceColor.r * (1.0 - overlay.a);
  }

  mediump float ga;
  if (overlay.a == 0.0 || ((sourceColor.g / overlay.g) > (sourceColor.a / overlay.a))) {
    ga = overlay.a * sourceColor.a + overlay.g * (1.0 - sourceColor.a) + sourceColor.g * (1.0 - overlay.a);
  } else {
    ga = (sourceColor.g * overlay.a * overlay.a) / overlay.g + overlay.g * (1.0 - sourceColor.a) + sourceColor.g * (1.0 - overlay.a);
  }

  mediump float ba;
  if (overlay.a == 0.0 || ((sourceColor.b / overlay.b) > (sourceColor.a / overlay.a))) {
    ba = overlay.a * sourceColor.a + overlay.b * (1.0 - sourceColor.a) + sourceColor.b * (1.0 - overlay.a);
  } else {
    ba = (sourceColor.b * overlay.a * overlay.a) / overlay.b + overlay.b * (1.0 - sourceColor.a) + sourceColor.b * (1.0 - overlay.a);
  }
  mediump float a = overlay.a + sourceColor.a - overlay.a * sourceColor.a;

  return vec4(ra, ga, ba, a);
}

void main() {
  mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

  gl_FragColor = processColor(textureColor);
}