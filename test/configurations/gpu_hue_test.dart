import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUHueConfiguration configuration;
  setUp(() {
    configuration = GPUHueConfiguration();
  });
  group('GPUHueConfiguration', () {
    test('change iinputHueAdjust', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputHueAdjust')
              as NumberParameter;
      expect(parameter.value, 90);
      configuration.hue = 45;
      expect(parameter.value, 45);
    });
  });
}
