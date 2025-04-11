import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPULuminanceThresholdConfiguration configuration;
  setUp(() {
    configuration = GPULuminanceThresholdConfiguration();
  });
  group('GPULuminanceThresholdConfiguration', () {
    test('change inputThreshold', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputThreshold')
              as NumberParameter;
      expect(parameter.value, 0.5);
      configuration.threshold = 0.8;
      expect(parameter.value, 0.8);
    });
  });
}
