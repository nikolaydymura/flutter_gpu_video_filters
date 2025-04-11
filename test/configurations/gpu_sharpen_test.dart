import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUSharpenConfiguration configuration;
  setUp(() {
    configuration = GPUSharpenConfiguration();
  });
  group('GPUSharpenConfiguration', () {
    test('change inputImageWidthFactor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputImageWidthFactor',
              )
              as NumberParameter;
      expect(parameter.value, 0.004);
      configuration.imageWidthFactor = 2.0;
      expect(parameter.value, 2.0);
    });

    test('change inputImageHeightFactor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputImageHeightFactor',
              )
              as NumberParameter;
      expect(parameter.value, 0.004);
      configuration.imageHeightFactor = 2.0;
      expect(parameter.value, 2.0);
    });

    test('change inputSharpness', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputSharpness')
              as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.sharpness = 2.0;
      expect(parameter.value, 2.0);
    });
  });
}
