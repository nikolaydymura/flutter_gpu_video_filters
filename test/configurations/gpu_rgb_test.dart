import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPURGBConfiguration configuration;
  setUp(() {
    configuration = GPURGBConfiguration();
  });
  group('GPURGBConfiguration', () {
    test('change inputRed', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputRed')
              as NumberParameter;
      expect(parameter.value, 255.0);
      configuration.red = 100.0;
      expect(parameter.value, 100.0);
    });

    test('change inputGreen', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputGreen')
              as NumberParameter;
      expect(parameter.value, 255.0);
      configuration.green = 100.0;
      expect(parameter.value, 100.0);
    });

    test('change inputBlue', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputBlue')
              as NumberParameter;
      expect(parameter.value, 255.0);
      configuration.blue = 100.0;
      expect(parameter.value, 100.0);
    });
  });
}
