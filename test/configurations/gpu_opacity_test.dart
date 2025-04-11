import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUOpacityConfiguration configuration;
  setUp(() {
    configuration = GPUOpacityConfiguration();
  });
  group('GPUOpacityConfiguration', () {
    test('change inputOpacity', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputOpacity')
              as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.opacity = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
