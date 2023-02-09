
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

<p align="center">
<a href="https://pub.dev/packages/flutter_gpu_video_filters"><img src="https://img.shields.io/pub/v/flutter_gpu_video_filters.svg" alt="Pub"></a>
<a href="https://codecov.io/gh/nikolaydymura/flutter_gpu_video_filters"><img src="https://codecov.io/gh/nikolaydymura/flutter_gpu_video_filters/main/master/graph/badge.svg?token=U9FUTYJ6SV" alt="codecov"></a>
<a href="https://github.com/nikolaydymura/flutter_gpu_video_filters/actions"><img src="https://github.com/nikolaydymura/flutter_gpu_video_filters/actions/workflows/flutter_gpu_video_filters.yaml/badge.svg" alt="build"></a>
<a href="https://github.com/nikolaydymura/flutter_gpu_video_filters"><img src="https://img.shields.io/github/stars/nikolaydymura/flutter_gpu_video_filters.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

A flutter package for Android for applying OpenGL filters to video.

## Usage

### Export & save video

```dart
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

final inputSource = AssetInputSource('demo.mp4');
final output = File('result.mp4');
final configuration = GPUGrayScaleConfiguration();
final processStream =  configuration.exportVideoFile(VideoExportConfig(AssetInputSource(asset), output));
await for (final progress in processStream) {
  debugPrint('Exporting file ${(progress * 100).toInt()}%');
}
```

### GPUVideoNativePreview example
```dart
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

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
    return paramsReady
        ? GPUVideoNativePreview(
      params: previewParams,
      configuration: configuration,
      onViewCreated: (controller, outputSizeStream) async {
        controller = controller;
        controller.setVideoAsset(_assetPath);
        await for (final size in outputSizeStream) {
          setState(() {});
        }
      },
    )
        : const Offstage();
  }
}
```

## Additional information

### Support status of [GPUImage for Android](https://github.com/cats-oss/android-gpuimage) shaders

| Status             | Name                                          | Display Name                     |
|:-------------------|:----------------------------------------------|:---------------------------------|
| :white_check_mark: | GPU3x3ConvolutionConfiguration                | 3x3 Convolution                  |
| :white_check_mark: | GPUAddBlendConfiguration                      | Add Blend                        |
| :white_check_mark: | GPUAlphaBlendConfiguration                    | Alpha Blend                      |
| :x:                | GPUBilateralConfiguration                     | Bilateral                        |
| :x:                | GPUBoxBlurConfiguration                       | Box Blur                         |
| :white_check_mark: | GPUBrightnessConfiguration                    | Brightness                       |
| :white_check_mark: | GPUBulgeDistortionConfiguration               | Bulge Distortion Configuration   |
| :white_check_mark: | GPUCGAColorspaceConfiguration                 | CGA Colorspace                   |
| :white_check_mark: | GPUChromaKeyBlendConfiguration                | Chroma Key Blend                 |
| :white_check_mark: | GPUColorBalanceConfiguration                  | Color Balance                    |
| :white_check_mark: | GPUColorBlendConfiguration                    | Color Blend                      |
| :white_check_mark: | GPUColorBurnBlendConfiguration                | Color Burn Blend                 |
| :white_check_mark: | GPUColorDodgeBlendConfiguration               | Color Dodge Blend                |
| :white_check_mark: | GPUColorInvertConfiguration                   | Color Invert                     |
| :white_check_mark: | GPUColorMatrixConfiguration                   | Color Matrix                     |
| :white_check_mark: | GPUContrastConfiguration                      | Contrast                         |
| :white_check_mark: | GPUCrosshatchConfiguration                    | Crosshatch                       |
| :white_check_mark: | GPUDarkenBlendConfiguration                   | Darken Blend                     |
| :white_check_mark: | GPUDifferenceBlendConfiguration               | Difference Blend                 |
| :white_check_mark: | GPUDirectionalSobelEdgeDetectionConfiguration | Directional Sobel Edge Detection |
| :white_check_mark: | GPUDissolveBlendConfiguration                 | Dissolve Blend                   |
| :white_check_mark: | GPUDivideBlendConfiguration                   | Divide Blend                     |
| :white_check_mark: | GPUEmbossConfiguration                        | Emboss                           |
| :white_check_mark: | GPUExposureConfiguration                      | Exposure                         |
| :white_check_mark: | GPUFalseColorConfiguration                    | False Color                      |
| :white_check_mark: | GPUGammaConfiguration                         | Gamma                            |
| :x:                | GPUGaussianBlurConfiguration                  | Gaussian Blur                    |
| :white_check_mark: | GPUGlassSphereConfiguration                   | Glass Sphere                     |
| :white_check_mark: | GPUGrayScaleConfiguration                     | Gray Scale                       |
| :white_check_mark: | GPUHALDLookupTableConfiguration               | HALD Lookup Table                |
| :white_check_mark: | GPUHalftoneConfiguration                      | Halftone                         |
| :white_check_mark: | GPUHardLightBlendConfiguration                | Hard Light Blend                 |
| :white_check_mark: | GPUHazeConfiguration                          | Haze                             |
| :white_check_mark: | GPUHighlightShadowConfiguration               | Highlight Shadow                 |
| :white_check_mark: | GPUHueBlendConfiguration                      | Hue Blend                        |
| :white_check_mark: | GPUHueConfiguration                           | Hue                              |
| :white_check_mark: | GPUInvertConfiguration                        | Invert                           |
| :white_check_mark: | GPUKuwaharaConfiguration                      | Kuwahara                         |
| :white_check_mark: | GPULaplacianConfiguration                     | Laplacian                        |
| :white_check_mark: | GPULevelsConfiguration                        | Levels                           |
| :white_check_mark: | GPULightenBlendConfiguration                  | Lighten Blend                    |
| :white_check_mark: | GPULinearBurnBlendConfiguration               | Linear Burn Blend                |
| :white_check_mark: | GPULuminanceThresholdConfiguration            | Luminance Threshold              |
| :white_check_mark: | GPULuminanceConfiguration                     | Luminance                        |
| :white_check_mark: | GPULuminosityBlendConfiguration               | Luminosity Blend                 |
| :white_check_mark: | GPUMonochromeConfiguration                    | Monochrome                       |
| :white_check_mark: | GPUMultiplyBlendConfiguration                 | Multiply Blend                   |
| :white_check_mark: | GPUNonMaximumSuppressionConfiguration         | Non Maximum Suppression          |
| :white_check_mark: | GPUNormalBlendConfiguration                   | Normal Blend                     |
| :interrobang:      | GPUOpacityConfiguration                       | Opacity                          |
| :white_check_mark: | GPUOverlayBlendConfiguration                  | Overlay Blend                    |
| :white_check_mark: | GPUOverlayConfiguration                       | Overlay                          |
| :white_check_mark: | GPUPixelationConfiguration                    | Pixelation                       |
| :white_check_mark: | GPUPosterizeConfiguration                     | Posterize                        |
| :white_check_mark: | GPURGBConfiguration                           | RGB                              |
| :white_check_mark: | GPUSaturationBlendConfiguration               | Saturation Blend                 |
| :white_check_mark: | GPUSaturationConfiguration                    | Saturation                       |
| :white_check_mark: | GPUScreenBlendConfiguration                   | Screen Blend                     |
| :white_check_mark: | GPUSepiaToneConfiguration                     | Sepia Tone                       |
| :white_check_mark: | GPUSepiaConfiguration                         | Sepia                            |
| :white_check_mark: | GPUSharpenConfiguration                       | Sharpen                          |
| :white_check_mark: | GPUSobelThresholdConfiguration                | Sobel Threshold                  |
| :white_check_mark: | GPUSoftLightBlendConfiguration                | Soft Light Blend                 |
| :white_check_mark: | GPUSolarizeConfiguration                      | Solarize                         |
| :white_check_mark: | GPUSourceOverBlendConfiguration               | Source Over Blend                |
| :white_check_mark: | GPUSphereRefractionConfiguration              | Sphere Refraction                |
| :white_check_mark: | GPUSquareLookupTableConfiguration             | Square Lookup Table              |
| :white_check_mark: | GPUSubtractBlendConfiguration                 | Subtract Blend                   |
| :white_check_mark: | GPUSwirlConfiguration                         | Swirl                            |
| :white_check_mark: | GPUToneCurveConfiguration                     | Tone Curve                       |
| :white_check_mark: | GPUToonConfiguration                          | Toon                             |
| :white_check_mark: | GPUVibranceConfiguration                      | Vibrance                         |
| :white_check_mark: | GPUVignetteConfiguration                      | Vignette                         |
| :white_check_mark: | GPUWatermarkConfiguration                     | Watermark                        |
| :white_check_mark: | GPUWeakPixelInclusionConfiguration            | Weak Pixel Inclusion             |
| :white_check_mark: | GPUWhiteBalanceConfiguration                  | WhiteBalance                     |
| :white_check_mark: | GPUZoomBlurConfiguration                      | Zoom Blur                        |

## Examples

- [Big Flutter Filters Demo](https://github.com/nikolaydymura/image_filters_example) - big example of how to use filters and.

## Maintainers

- [Nikolay Dymura](https://github.com/nikolaydymura)
- [Egor Terekhov](https://github.com/EgorEko)
- [Nataliia Zabiiaka](https://github.com/nataliiazabiiaka)

