import 'dart:ui';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUFalseColorConfiguration configuration;
  setUp(() {
    configuration = GPUFalseColorConfiguration();
  });
  group('GPUFalseColorConfiguration', () {
    test('change inputFirstColor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputFirstColor',
              )
              as ColorParameter;
      expect(parameter.value, const Color.fromRGBO(0, 0, 127, 1.0));
      configuration.firstColor = const Color.fromRGBO(239, 40, 17, 1.0);
      expect(parameter.value, const Color.fromRGBO(239, 40, 17, 1.0));
    });

    test('change inputSecondColor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputSecondColor',
              )
              as ColorParameter;
      expect(parameter.value, const Color.fromRGBO(255, 0, 0, 1.0));
      configuration.secondColor = const Color.fromRGBO(45, 74, 17, 1.0);
      expect(parameter.value, const Color.fromRGBO(45, 74, 17, 1.0));
    });
  });
}
