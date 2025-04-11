import 'dart:math';
import 'dart:ui';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUGlassSphereConfiguration configuration;
  setUp(() {
    configuration = GPUGlassSphereConfiguration();
  });
  group('GPUGlassSphereConfiguration', () {
    test('change inputCenter', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputCenter')
              as PointParameter;
      expect(parameter.value, const Point(0.5, 0.5));
      configuration.center = const Point(1.0, 1.0);
      expect(parameter.value, const Point(1.0, 1.0));
    });

    test('change inputAspectRatio', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputAspectRatio',
              )
              as AspectRatioParameter;
      expect(parameter.value, const Size(1.0, 1.0));
      configuration.aspectRatio = const Size(0.5, 0.5);
      expect(parameter.value, const Size(0.5, 0.5));
    });

    test('change inputRadius', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputRadius')
              as NumberParameter;
      expect(parameter.value, 0.25);
      configuration.radius = 0.7;
      expect(parameter.value, 0.7);
    });

    test('change inputRefractiveIndex', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputRefractiveIndex',
              )
              as NumberParameter;
      expect(parameter.value, 0.71);
      configuration.refractiveIndex = 1.0;
      expect(parameter.value, 1.0);
    });
  });
}
