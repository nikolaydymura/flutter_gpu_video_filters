## Define custom configuration

### 1. Add new shader file to list of assets in `pubspec.yaml`
```yaml
# The following section is specific to Flutter packages.
flutter:
  uses-material-design: true
  assets:
    - shaders/Custom.glsl
```

Shader must contain two variable 

```glsl
varying highp vec2 textureCoordinate; // texture coordinates

uniform sampler2D inputImageTexture; // input video frame
```

If you need to allow your function to be part of shader's bunch add `vec4 processColor(vec4 sourceColor)` function

```glsl
vec4 processColor(vec4 sourceColor){
   ...
}

void main() {
    highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}
```
### 2. Create class extended from `GPUFilterConfiguration` and define inputs of filter

## Example

Let's update `Brightness` shader to apple value `-0.2` and save it to `shaders/CustomBrightness.glsl`

```glsl
precision mediump float;
varying vec2 textureCoordinate;

uniform lowp sampler2D inputImageTexture;
uniform lowp float inputBrightness;

vec4 processColor(vec4 sourceColor){
    return vec4((sourceColor.rgb + vec3(inputBrightness - 0.2)), sourceColor.w);
}

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);

    gl_FragColor = processColor(textureColor);
}
```

```dart

class GPUCustomBrightnessConfiguration extends GPUFilterConfiguration {
  final NumberParameter _brightness;

  GPUCustomBrightnessConfiguration()
      : _brightness = GLSliderFloatParameter(
    'inputBrightness', // uniform name
    'Brightness', // display name
    0, // default value
    min: -1, // minimum value
    max: 1, // maximum value
  ),
        super('CustomBrightness', // glsl file name
          fragmentShadersPath: 'shaders' // assets location
      );

  // custom setter (optional)
  set brightness(double value) {
    _brightness.value = value;
  }

  // enlist all parameters
  @override
  List<ConfigurationParameter> get parameters => [_brightness];
}
```