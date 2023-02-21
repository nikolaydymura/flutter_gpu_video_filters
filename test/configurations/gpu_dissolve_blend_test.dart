import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUDissolveBlendConfiguration configuration;
  setUp(() {
    configuration = GPUDissolveBlendConfiguration();
  });
  group('GPUDissolveBlendConfiguration', () {
    test('change inputMixturePercent', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputMixturePercent')
          as NumberParameter;
      expect(parameter.value, 0.5);
      configuration.mixturePercent = 0.7;
      expect(parameter.value, 0.7);
    });
  });
}
