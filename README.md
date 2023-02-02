
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

<p align="center">
<a href="https://pub.dev/packages/flutter_gpu_video_filters"><img src="https://img.shields.io/pub/v/flutter_gpu_video_filters.svg" alt="Pub"></a>
<a href="https://codecov.io/gh/nikolaydymura/flutter_gpu_video_filters"><img src="https://codecov.io/gh/nikolaydymura/flutter_gpu_video_filters/main/master/graph/badge.svg?token=8WE5JDOLGS" alt="codecov"></a>
<a href="https://github.com/nikolaydymura/flutter_gpu_video_filters/actions"><img src="https://github.com/nikolaydymura/flutter_gpu_video_filters/actions/workflows/flutter_gpu_video_filters.yaml/badge.svg" alt="build"></a>
<a href="https://github.com/nikolaydymura/flutter_gpu_video_filters"><img src="https://img.shields.io/github/stars/nikolaydymura/flutter_gpu_video_filters.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

A flutter package for Android for applying OpenGL filters to video.

## Usage

### Export & save video

```dart
final inputSource = AssetInputSource('demo.mp4');
final output = File('result.mp4');
final configuration = GPUGrayScaleConfiguration();
final processStream = await configuration.exportVideoFile(VideoExportConfig(AssetInputSource(asset), output));
await for (final progress in processStream) {
  debugPrint('Exporting file ${progress.toInt()}%');
}
```

### GPUVideoNativePreview example
```dart
import 'package:flutter_image_filters/flutter_image_filters.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late GPUVideoPreviewController configuration;
  late final GPUGrayScaleConfiguration controller;
  late final GPUVideoPreviewParams previewParams;
  bool paramsReady = false;

  @override
  void initState() {
    super.initState();
    _prepare().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _prepare() async {
    configuration = GPUGrayScaleConfiguration();
    previewParams = await GPUVideoPreviewParams.create(configuration);
    paramsReady = true;
  }

  @override
  void dispose() {
    controller.dispose();
    configuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controllerReady
        ? GPUVideoNativePreview(
      params: previewParams,
      configuration: configuration,
      onViewCreated: (controller) {
        this.controller = controller;
        this.controller.setVideoAsset(_assetPath);
      },
    )
        : const Offstage();
  }
}
```

## Additional information

### Support status of [GPUImage for Android](https://github.com/cats-oss/android-gpuimage) shaders

| Status             | Name                              | Display Name                      |
|:-------------------|:----------------------------------|:----------------------------------|
| :x:                | CIAccordionFoldTransition         | Accordion Fold Transition         |
| :white_check_mark: | CIBloom                           | Bloom                             |

## Examples

- [Big Flutter Filters Demo](https://github.com/nikolaydymura/image_filters_example) - big example of how to use filters and.

## Maintainers

- [Nikolay Dymura](https://github.com/nikolaydymura)
- [Egor Terekhov](https://github.com/EgorEko)
- [Nataliia Zabiiaka](https://github.com/nataliiazabiiaka)

