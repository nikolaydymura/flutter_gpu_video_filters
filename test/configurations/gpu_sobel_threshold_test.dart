import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSobelThresholdConfiguration configuration;
  setUp(() {
    configuration = GPUSobelThresholdConfiguration();
  });
  group('GPUSobelThresholdConfiguration', () {
    test('change inputThreshold', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputThreshold')
              as NumberParameter;
      expect(parameter.value, 0.9);
      configuration.intensity = 2.0;
      expect(parameter.value, 2.0);
    });
  });
}
