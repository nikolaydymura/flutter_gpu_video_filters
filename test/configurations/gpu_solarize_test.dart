import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSolarizeConfiguration configuration;
  setUp(() {
    configuration = GPUSolarizeConfiguration();
  });
  group('GPUSolarizeConfiguration', () {
    test('change inputThreshold', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputThreshold') as NumberParameter;
      expect(parameter.value, 0.5);
      configuration.threshold = 2.0;
      expect(parameter.value, 2.0);
    });
  });
}
