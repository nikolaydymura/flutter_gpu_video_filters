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
          .firstWhere((e) => e.name == 'inputLevelMinimum') as Vector3Parameter;
      expect(parameter.value.storage, [0.0, 0.0, 0.0]);
      configuration.levelMinimum = Vector3(1.0, 0.0, 0.0);
      expect(parameter.value.storage, [1.0, 0.0, 0.0]);
    });

    test('change inputLevelMiddle', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLevelMiddle') as Vector3Parameter;
      expect(parameter.value.storage, [1.0, 1.0, 1.0]);
      configuration.levelMiddle = Vector3(0.0, 0.0, 1.0);
      expect(parameter.value.storage, [0.0, 0.0, 1.0]);
    });

    test('change inputLevelMaximum', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputLevelMaximum') as Vector3Parameter;
      expect(parameter.value.storage, [1.0, 1.0, 1.0]);
      configuration.levelMaximum = Vector3(0.0, 0.0, 1.0);
      expect(parameter.value.storage, [0.0, 0.0, 1.0]);
    });

    test('change inputMinOutput', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputMinOutput') as Vector3Parameter;
      expect(parameter.value.storage, [0.0, 0.0, 0.0]);
      configuration.minOutput = Vector3(1.0, 1.0, 1.0);
      expect(parameter.value.storage, [1.0, 1.0, 1.0]);
    });

    test('change inputMaxOutput', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputMaxOutput') as Vector3Parameter;
      expect(parameter.value.storage, [1.0, 1.0, 1.0]);
      configuration.maxOutput = Vector3(2.0, 2.0, 2.0);
      expect(parameter.value.storage, [2.0, 2.0, 2.0]);
    });
  });
}
