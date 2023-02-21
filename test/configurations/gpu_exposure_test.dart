import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUExposureConfiguration configuration;
  setUp(() {
    configuration = GPUExposureConfiguration();
  });
  group('GPUExposureConfiguration', () {
    test('change inputExposure', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputExposure')
      as NumberParameter;
      expect(parameter.value, 0);
      configuration.exposure = 5;
      expect(parameter.value, 5);
    });
  });
}
