import 'dart:math';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUZoomBlurConfiguration configuration;
  setUp(() {
    configuration = GPUZoomBlurConfiguration();
  });
  group('GPUZoomBlurConfiguration', () {
    test('change inputBlurCenter', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputBlurCenter') as PointParameter;
      expect(parameter.value, const Point(0.5, 0.5));
      configuration.center = const Point(1.0, 1.0);
      expect(parameter.value, const Point(1.0, 1.0));
    });

    test('change inputBlurSize', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputBlurSize') as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.blurSize = 2.0;
      expect(parameter.value, 2.0);
    });
  });
}
