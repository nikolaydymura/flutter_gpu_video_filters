import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUContrastConfiguration configuration;
  setUp(() {
    configuration = GPUContrastConfiguration();
  });
  group('GPUContrastConfiguration', () {
    test('change inputContrast', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputContrast')
              as NumberParameter;
      expect(parameter.value, 1.2);
      configuration.contrast = 2;
      expect(parameter.value, 2);
    });
  });
}
