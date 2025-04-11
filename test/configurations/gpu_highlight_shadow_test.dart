import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUHighlightShadowConfiguration configuration;
  setUp(() {
    configuration = GPUHighlightShadowConfiguration();
  });
  group('GPUHighlightShadowConfiguration', () {
    test('change inputShadows', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputShadows')
              as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.shadows = 2.0;
      expect(parameter.value, 2.0);
    });

    test('change inputHighlights', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputHighlights',
              )
              as NumberParameter;
      expect(parameter.value, 0.0);
      configuration.highlights = 1.0;
      expect(parameter.value, 1.0);
    });
  });
}
