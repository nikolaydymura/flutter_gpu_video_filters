import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUWhiteBalanceConfiguration configuration;
  setUp(() {
    configuration = GPUWhiteBalanceConfiguration();
  });
  group('GPUWhiteBalanceConfiguration', () {
    test('change inputTemperature', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputTemperature') as NumberParameter;
      expect(parameter.value, 5000);
      configuration.temperature = 2500;
      expect(parameter.value, 2500);
    });

    test('change inputTint', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputTint') as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.tint = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
