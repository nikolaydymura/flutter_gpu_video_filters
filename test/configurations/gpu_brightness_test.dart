import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUBrightnessConfiguration configuration;
  setUp(() {
    configuration = GPUBrightnessConfiguration();
  });
  group('GPUBrightnessConfiguration', () {
    test('change inputBrightness', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputBrightness',
              )
              as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.brightness = -0.5;
      expect(parameter.value, -0.5);
    });
  });
}
