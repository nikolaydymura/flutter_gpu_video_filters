import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUGammaConfiguration configuration;
  setUp(() {
    configuration = GPUGammaConfiguration();
  });
  group('GPUGammaConfiguration', () {
    test('change inputGamma', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputGamma')
              as NumberParameter;
      expect(parameter.value, 1.2);
      configuration.gamma = 3;
      expect(parameter.value, 3);
    });
  });
}
