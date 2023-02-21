import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSaturationConfiguration configuration;
  setUp(() {
    configuration = GPUSaturationConfiguration();
  });
  group('GPUSaturationConfiguration', () {
    test('change inputSaturation', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputSaturation') as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.saturation = 2.0;
      expect(parameter.value, 2.0);
    });
  });
}
