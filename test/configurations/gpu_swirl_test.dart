import 'dart:math';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSwirlConfiguration configuration;
  setUp(() {
    configuration = GPUSwirlConfiguration();
  });
  group('GPUSwirlConfiguration', () {
    test('change inputCenter', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputCenter') as PointParameter;
      expect(parameter.value, const Point(0.5, 0.5));
      configuration.center = const Point(2.5, 2.5);
      expect(parameter.value, const Point(2.5, 2.5));
    });

    test('change inputAngle', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputAngle') as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.scale = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputRadius', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputRadius') as NumberParameter;
      expect(parameter.value, 0.5);
      configuration.radius = 1.0;
      expect(parameter.value, 1.0);
    });
  });
}
