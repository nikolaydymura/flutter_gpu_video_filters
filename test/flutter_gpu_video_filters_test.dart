import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify amount', () {
    expect(
      FlutterVideoFilters.availableFilters.length,
      greaterThanOrEqualTo(40),
    );
  });
  test('enlist all', () async {
    final filters = [
      'Bilateral',
      'Box Blur',
      'Brightness',
      'Bulge Distortion Configuration',
      'CGA Colorspace',
      'Contrast',
      'Crosshatch',
      'Exposure',
      'Gamma',
      'Lookup Table',
      'Monochrome',
      'Gaussian Blur',
      'Gray Scale',
      'Halftone',
      'Haze',
      'Highlight Shadow',
      'Hue',
      'Invert',
      'Luminance',
      'Luminance Threshold',
      'Opacity',
      'Overlay',
      'Pixelation',
      'Posterize',
      'RGB',
      'Saturation',
      'Sepia',
      'Sharpen',
      'Solarize',
      'Sphere Refraction',
      'Swirl',
      'Three x3 Texture Sampling',
      'Tone',
      'Tone Curve',
      'Vibrance',
      'Vignette',
      'Watermark',
      'Weak Pixel Inclusion',
      'WhiteBalance',
      'Zoom Blur'
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
