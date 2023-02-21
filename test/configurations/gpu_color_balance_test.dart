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
          .firstWhere((e) => e.name == 'inputShadowsShift') as VectorParameter;
      expect(parameter.value, [0.0, 0.0, 0.0]);
      configuration.shadowsShift = [1.0, 0.0, 0.0];
      expect(parameter.value, [1.0, 0.0, 0.0]);
    });

    test('change inputMidtonesShift', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputMidtonesShift') as VectorParameter;
      expect(parameter.value, [0.0, 0.0, 0.0]);
      configuration.midtonesShift = [0.0, 0.0, 1.0];
      expect(parameter.value, [0.0, 0.0, 1.0]);
    });

    test('change inputHighlightsShift', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputHighlightsShift')
          as VectorParameter;
      expect(parameter.value, [0.0, 0.0, 0.0]);
      configuration.highlightsShift = [0.0, 0.0, 1.0];
      expect(parameter.value, [0.0, 0.0, 1.0]);
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
