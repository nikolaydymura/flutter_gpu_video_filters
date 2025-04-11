import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUHalftoneConfiguration configuration;
  setUp(() {
    configuration = GPUHalftoneConfiguration();
  });
  group('GPUHalftoneConfiguration', () {
    test('change inputFractionalWidthOfPixel', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputFractionalWidthOfPixel',
              )
              as NumberParameter;
      expect(parameter.value, 0.01);
      configuration.fractionalWidthOfPixel = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputAspectRatio', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputAspectRatio',
              )
              as NumberParameter;
      expect(parameter.value, 1);
      configuration.aspectRatio = 2;
      expect(parameter.value, 2);
    });
  });
}
