precision highp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform sampler2D inputTextureCubeData; // lookup texture

uniform lowp float inputIntensity;

vec2 computeSliceOffset(float slice, float slicesPerRow, vec2 sliceSize) {
  return sliceSize * vec2(mod(slice, slicesPerRow),
                          floor(slice / slicesPerRow));
}

vec4 sampleAs3DTexture(vec3 textureColor, float size, float numRows, float slicesPerRow) {
  float slice   = textureColor.z * 511.0;
  float zOffset = fract(slice);                         // dist between slices

  vec2 sliceSize = vec2(1.0 / slicesPerRow,             // u space of 1 slice
                        1.0 / numRows);                 // v space of 1 slice

  vec2 slice0Offset = computeSliceOffset(floor(slice), slicesPerRow, sliceSize);
  vec2 slice1Offset = computeSliceOffset(ceil(slice), slicesPerRow, sliceSize);

  vec2 slicePixelSize = sliceSize / size;               // space of 1 pixel
  vec2 sliceInnerSize = slicePixelSize * (size - 1.0);  // space of size pixels

  vec2 uv = slicePixelSize * 0.5 + textureColor.xy * sliceInnerSize;
  vec4 slice0Color = texture2D(inputTextureCubeData, slice0Offset + uv);
  vec4 slice1Color = texture2D(inputTextureCubeData, slice1Offset + uv);
  return mix(slice0Color, slice1Color, zOffset);
}

vec4 processColor(vec4 sourceColor){
   vec4 newColor = sampleAs3DTexture(sourceColor.rgb, 8.0, 64.0, 8.0);
   return mix(sourceColor, vec4(newColor.rgb, sourceColor.w), inputIntensity);
}

void main() {
    highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}