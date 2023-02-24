import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify amount', () {
    expect(
      FlutterVideoFilters.availableFilters.length,
      greaterThanOrEqualTo(77),
    );
  });
  test('filter not defined', () {
    expect(
      () => FlutterVideoFilters.createFilter(displayName: 'Big Filter'),
      throwsA(isA<String>()),
    );
  });
  test('enlist all', () {
    final filters = [
      '3x3 Convolution',
      'Add Blend',
      'Alpha Blend',
      'Bilateral',
      'Box Blur',
      'Brightness',
      'Bulge Distortion Configuration',
      'CGA Colorspace',
      'Chroma Key Blend',
      'Color Balance',
      'Color Blend',
      'Color Burn Blend',
      'Color Dodge Blend',
      'Color Invert',
      'Color Matrix',
      'Contrast',
      'Crosshatch',
      'Darken Blend',
      'Difference Blend',
      'Directional Sobel Edge Detection',
      'Dissolve Blend',
      'Divide Blend',
      'Emboss',
      'Exposure',
      'False Color',
      'Gamma',
      'Gaussian Blur',
      'Glass Sphere',
      'Gray Scale',
      'HALD Lookup Table',
      'Halftone',
      'Hard Light Blend',
      'Haze',
      'Highlight Shadow',
      'Hue Blend',
      'Hue',
      'Invert',
      'Kuwahara',
      'Laplacian',
      'Levels',
      'Lighten Blend',
      'Linear Burn Blend',
      'Luminance Threshold',
      'Luminance',
      'Luminosity Blend',
      'Monochrome',
      'Multiply Blend',
      'Non Maximum Suppression',
      'Normal Blend',
      'Opacity',
      'Overlay Blend',
      'Overlay',
      'Pixelation',
      'Posterize',
      'RGB',
      'Saturation Blend',
      'Saturation',
      'Screen Blend',
      'Sepia Tone',
      'Sepia',
      'Sharpen',
      'Sobel Threshold',
      'Soft Light Blend',
      'Solarize',
      'Source Over Blend',
      'Sphere Refraction',
      'Square Lookup Table',
      'Subtract Blend',
      'Swirl',
      'Tone Curve',
      'Toon',
      'Vibrance',
      'Vignette',
      'Watermark',
      'Weak Pixel Inclusion',
      'WhiteBalance',
      'Zoom Blur',
    ];
    for (final name in filters) {
      final configuration = FlutterVideoFilters.createFilter(displayName: name);
      expect(configuration, isNotNull, reason: '`$name` not implemented');
    }
    for (final name in FlutterVideoFilters.availableFilters) {
      expect(filters.contains(name), true);
    }
  });
}
