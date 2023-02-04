import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify amount', () {
    expect(
      FlutterVideoFilters.availableFilters.length,
      greaterThanOrEqualTo(63),
    );
  });
  test('enlist all', () async {
    final filters = [
      'Add Blend',
      'Alpha Blend',
      'Bilateral',
      'Box Blur',
      'Brightness',
      'Bulge Distortion Configuration',
      'CGA Colorspace',
      'Chroma Key Blend',
      'Color Blend',
      'Color Burn Blend',
      'Color Dodge Blend',
      'Contrast',
      'Crosshatch',
      'Darken Blend',
      'Difference Blend',
      'Dissolve Blend',
      'Divide Blend',
      'Exposure',
      'Gamma',
      'Gaussian Blur',
      'Gray Scale',
      'HALD Lookup Table',
      'Halftone',
      'Hard Light Blend',
      'Haze',
      'Highlight Shadow',
      'Hue Blend',
      'Hue',
      'Invert',
      'Lighten Blend',
      'Linear Burn Blend',
      'Luminance Threshold',
      'Luminance',
      'Luminosity Blend',
      'Monochrome',
      'Multiply Blend',
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
      'Sepia',
      'Sharpen',
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
