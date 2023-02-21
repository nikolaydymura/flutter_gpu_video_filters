import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUHazeConfiguration configuration;
  setUp(() {
    configuration = GPUHazeConfiguration();
  });
  group('GPUHazeConfiguration', () {
    test('change inputDistance', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputDistance') as NumberParameter;
      expect(parameter.value, 0.2);
      configuration.distance = 1.0;
      expect(parameter.value, 1.0);
    });

    test('change inputSlope', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputSlope') as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.slope = 1.0;
      expect(parameter.value, 1.0);
    });
  });
}
