import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUPixelationConfiguration configuration;
  setUp(() {
    configuration = GPUPixelationConfiguration();
  });
  group('GPUPixelationConfiguration', () {
    test('change inputPixel', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputPixel')
              as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.pixel = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputImageWidthFactor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputImageWidthFactor',
              )
              as NumberParameter;
      expect(parameter.value, 1 / 720);
      configuration.imageWidthFactor = 320 / 720;
      expect(parameter.value, 320 / 720);
    });

    test('change inputImageHeightFactor', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputImageHeightFactor',
              )
              as NumberParameter;
      expect(parameter.value, 1 / 720);
      configuration.imageHeightFactor = 320 / 720;
      expect(parameter.value, 320 / 720);
    });
  });
}
