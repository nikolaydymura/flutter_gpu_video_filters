import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUBilateralConfiguration configuration;
  setUp(() {
    configuration = GPUBilateralConfiguration();
  });
  group('GPUBilateralConfiguration', () {
    test('change inputTexelWidthOffset', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputTexelWidthOffset')
          as NumberParameter;
      expect(parameter.value, 0.004);
      configuration.texelWidthOffset = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputTexelHeightOffset', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputTexelHeightOffset')
          as NumberParameter;
      expect(parameter.value, 0.004);
      configuration.texelHeightOffset = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputBlurSize', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputBlurSize') as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.blurSize = 0.5;
      expect(parameter.value, 0.5);
    });
  });
}
