import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUPosterizeConfiguration configuration;
  setUp(() {
    configuration = GPUPosterizeConfiguration();
  });
  group('GPUPosterizeConfiguration', () {
    test('change inputColorLevels', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputColorLevels') as NumberParameter;
      expect(parameter.value, 10.0);
      configuration.colorLevels = 5.0;
      expect(parameter.value, 5.0);
    });
  });
}
