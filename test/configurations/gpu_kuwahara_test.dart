import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUKuwaharaConfiguration configuration;
  setUp(() {
    configuration = GPUKuwaharaConfiguration();
  });
  group('GPUKuwaharaConfiguration', () {
    test('change inputRadius', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputRadius') as NumberParameter;
      expect(parameter.value, 3);
      configuration.radius = 1;
      expect(parameter.value, 1);
    });
  });
}
