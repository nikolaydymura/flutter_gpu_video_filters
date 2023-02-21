import 'dart:ui';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUChromaKeyBlendConfiguration configuration;
  setUp(() {
    configuration = GPUChromaKeyBlendConfiguration();
  });
  group('GPUChromaKeyBlendConfiguration', () {
    test('change inputThresholdSensitivity', () {
      final parameter = configuration.parameters
              .firstWhere((e) => e.name == 'inputThresholdSensitivity')
          as NumberParameter;
      expect(parameter.value, 0.4);
      configuration.thresholdSensitivity = 0.2;
      expect(parameter.value, 0.2);
    });

    test('change inputSmoothing', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputSmoothing') as NumberParameter;
      expect(parameter.value, 0.1);
      configuration.smoothing = 0.5;
      expect(parameter.value, 0.5);
    });

    test('change inputColorToReplace', () {
      final parameter = configuration.parameters
          .firstWhere((e) => e.name == 'inputColorToReplace') as ColorParameter;
      expect(parameter.value, const Color.fromRGBO(0, 255, 0, 1.0));
      configuration.colorToReplace = const Color.fromRGBO(255, 180, 0, 1.0);
      expect(parameter.value, const Color.fromRGBO(255, 180, 0, 1.0));
    });
  });
}
