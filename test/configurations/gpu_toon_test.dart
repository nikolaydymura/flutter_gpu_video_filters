import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUToonConfiguration configuration;
  setUp(() {
    configuration = GPUToonConfiguration();
  });
  group('GPUToonConfiguration', () {
    test('change inputThreshold', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputThreshold')
              as NumberParameter;
      expect(parameter.value, 0.2);
      configuration.threshold = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputQuantizationLevels', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputQuantizationLevels',
              )
              as NumberParameter;
      expect(parameter.value, 10.0);
      configuration.quantizationLevels = 5.0;
      expect(parameter.value, 5.0);
    });
  });
}
