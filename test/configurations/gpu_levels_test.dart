import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPULevelsConfiguration configuration;
  setUp(() {
    configuration = GPULevelsConfiguration();
  });
  group('GPULevelsConfiguration', () {
    test('change inputLevelMinimum', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLevelMinimum') as VectorParameter;
      expect(parameter.value, [0.0, 0.0, 0.0]);
      configuration.levelMinimum = [1.0, 0.0, 0.0];
      expect(parameter.value, [1.0, 0.0, 0.0]);
    });

    test('change inputLevelMiddle', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLevelMiddle') as VectorParameter;
      expect(parameter.value, [1.0, 1.0, 1.0]);
      configuration.levelMiddle = [0.0, 0.0, 1.0];
      expect(parameter.value, [0.0, 0.0, 1.0]);
    });

    test('change inputLevelMaximum', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLevelMaximum') as VectorParameter;
      expect(parameter.value, [1.0, 1.0, 1.0]);
      configuration.levelMaximum = [0.0, 0.0, 1.0];
      expect(parameter.value, [0.0, 0.0, 1.0]);
    });

    test('change inputMinOutput', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputMinOutput') as VectorParameter;
      expect(parameter.value, [0.0, 0.0, 0.0]);
      configuration.minOutput = [1.0, 1.0, 1.0];
      expect(parameter.value, [1.0, 1.0, 1.0]);
    });

    test('change inputMaxOutput', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputMaxOutput') as VectorParameter;
      expect(parameter.value, [1.0, 1.0, 1.0]);
      configuration.maxOutput = [2.0, 2.0, 2.0];
      expect(parameter.value, [2.0, 2.0, 2.0]);
    });
  });
}
