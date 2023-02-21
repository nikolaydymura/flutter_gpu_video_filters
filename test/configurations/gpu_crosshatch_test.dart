import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUCrosshatchConfiguration configuration;
  setUp(() {
    configuration = GPUCrosshatchConfiguration();
  });
  group('GPUCrosshatchConfiguration', () {
    test('change inputCrossHatchSpacing', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputCrossHatchSpacing')
          as NumberParameter;
      expect(parameter.value, 0.03);
      configuration.crossHatchSpacing = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputLineWidth', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLineWidth') as NumberParameter;
      expect(parameter.value, 0.003);
      configuration.lineWidth = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
