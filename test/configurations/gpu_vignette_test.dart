import 'dart:math';
import 'dart:ui';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUVignetteConfiguration configuration;
  setUp(() {
    configuration = GPUVignetteConfiguration();
  });
  group('GPUVignetteConfiguration', () {
    test('change inputVignetteCenter', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputVignetteCenter') as PointParameter;
      expect(parameter.value, const Point(0.0, 0.0));
      configuration.center = const Point(1.0, 1.0);
      expect(parameter.value, const Point(1.0, 1.0));
    });

    test('change inputVignetteColor', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputVignetteColor') as ColorParameter;
      expect(parameter.value, const Color.fromRGBO(0, 0, 0, 1.0));
      configuration.color = const Color.fromRGBO(255, 0, 0, 1.0);
      expect(parameter.value, const Color.fromRGBO(255, 0, 0, 1.0));
    });

    test('change inputVignetteStart', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputVignetteStart') as NumberParameter;
      expect(parameter.value, 0.3);
      configuration.vignetteStart = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputVignetteEnd', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputVignetteEnd') as NumberParameter;
      expect(parameter.value, 0.75);
      configuration.vignetteEnd = 0.9;
      expect(parameter.value, 0.9);
    });
  });
}
