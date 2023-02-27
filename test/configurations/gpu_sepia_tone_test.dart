import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSepiaToneConfiguration configuration;
  setUp(() {
    configuration = GPUSepiaToneConfiguration();
  });
  group('GPUSepiaToneConfiguration', () {
    test('change inputIntensity', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputIntensity') as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.intensity = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
