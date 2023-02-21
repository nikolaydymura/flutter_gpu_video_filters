import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUAlphaBlendConfiguration configuration;
  setUp(() {
    configuration = GPUAlphaBlendConfiguration();
  });
  group('GPUAlphaBlendConfiguration', () {
    test('change inputMixturePercent', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputMixturePercent')
          as NumberParameter;
      expect(parameter.value, 0.5);
      configuration.mixturePercent = 0.8;
      expect(parameter.value, 0.8);
    });
  });
}
