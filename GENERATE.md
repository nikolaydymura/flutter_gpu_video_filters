## Generate bunch of filters

### 1. View list of shaders available for processing

```shell
flutter pub run flutter_gpu_video_filters
```

### 2. Find filters you need and generate new shader

```shell
flutter pub run flutter_gpu_video_filters generate --filters Brightness,Contrast
```

### 3. Add new shader file to list of assets in `pubspec.yaml`
```yaml
# The following section is specific to Flutter packages.
flutter:
  uses-material-design: true
  assets:
    - shaders/Brightness+Contrast.glsl
```

### 4. Create new configuration

```dart
class BrightnessContrastFilterConfiguration extends BunchFilterConfiguration {
  BrightnessContrastFilterConfiguration()
      : super('shaders', [GPUBrightnessConfiguration(), GPUContrastConfiguration()]);
}
```