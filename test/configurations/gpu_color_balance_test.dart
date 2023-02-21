import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUColorBalanceConfiguration configuration;
  setUp(() {
    configuration = GPUColorBalanceConfiguration();
  });
  group('GPUColorBalanceConfiguration', () {
    test('change inputShadowsShift', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputShadowsShift') as Vector3Parameter;
      expect(parameter.value.storage, [0.0, 0.0, 0.0]);
      configuration.shadowsShift = Vector3(1.0, 0.0, 0.0);
      expect(parameter.value.storage, [1.0, 0.0, 0.0]);
    });

    test('change inputMidtonesShift', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputMidtonesShift')
          as Vector3Parameter;
      expect(parameter.value.storage, [0.0, 0.0, 0.0]);
      configuration.midtonesShift = Vector3(0.0, 0.0, 1.0);
      expect(parameter.value.storage, [0.0, 0.0, 1.0]);
    });

    test('change inputHighlightsShift', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputHighlightsShift')
          as Vector3Parameter;
      expect(parameter.value.storage, [0.0, 0.0, 0.0]);
      configuration.highlightsShift = Vector3(0.0, 0.0, 1.0);
      expect(parameter.value.storage, [0.0, 0.0, 1.0]);
    });

    test('change inputPreserveLuminosity', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputPreserveLuminosity')
          as BoolParameter;
      expect(parameter.value, true);
      configuration.preserveLuminosity = false;
      expect(parameter.value, false);
    });
  });
}
