import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUVibranceConfiguration configuration;
  setUp(() {
    configuration = GPUVibranceConfiguration();
  });
  group('GPUVibranceConfiguration', () {
    test('change inputVibrance', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputVibrance')
              as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.vibrance = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
