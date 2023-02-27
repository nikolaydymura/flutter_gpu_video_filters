import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUEmbossConfiguration configuration;
  setUp(() {
    configuration = GPUEmbossConfiguration();
  });
  group('GPUEmbossConfiguration', () {
    test('change inputIntensity', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputIntensity')
              as GLSliderComputeFloatParameter;
      expect(parameter.value, 1.0);
      configuration.intensity = 2.5;
      expect(parameter.value, 2.5);
    });

    test('inputTexelWidth', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputTexelWidth') as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.texelWidth = 2.5;
      expect(parameter.value, 2.5);
    });

    test('inputTexelHeight', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputTexelHeight') as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.texelHeight = 2.5;
      expect(parameter.value, 2.5);
    });
  });
}
