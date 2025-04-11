import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUHALDLookupTableConfiguration configuration;
  setUp(() {
    configuration = GPUHALDLookupTableConfiguration();
  });
  group('GPUHALDLookupTableConfiguration', () {
    test('change inputIntensity', () {
      final parameter =
          configuration.parameters.firstWhere((e) => e.name == 'inputIntensity')
              as NumberParameter;
      expect(parameter.value, 1.0);
      configuration.intensity = 0.5;
      expect(parameter.value, 0.5);
    });

    group('GPUSquareLookupTableConfiguration', () {
      test('change from asset', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureCubeData',
                )
                as DataParameter;
        expect(parameter.asset, isNull);
        configuration.lutImageAsset = 'demo.jpeg';
        expect(parameter.asset, 'demo.jpeg');
      });

      test('change from binary', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureCubeData',
                )
                as DataParameter;
        expect(parameter.data, isNull);
        final imageData = Uint8List(0);
        configuration.lutImage = imageData;
        expect(parameter.data, imageData);
      });

      test('change from file', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureCubeData',
                )
                as DataParameter;
        expect(parameter.file, isNull);
        final file = File('demo.jpeg');
        configuration.lutImageFile = file;
        expect(parameter.file, file);
      });
    });
  });
}
