import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUToneCurveConfiguration configuration;
  setUp(() {
    configuration = GPUToneCurveConfiguration();
  });
  group('GPUToneCurveConfiguration', () {
    group('inputTextureToneCurve', () {
      test('change from asset', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureToneCurve',
                )
                as DataParameter;
        expect(parameter.asset, isNull);
        configuration.toneCurveImageAsset = 'demo.jpeg';
        expect(parameter.asset, 'demo.jpeg');
      });

      test('change from binary', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureToneCurve',
                )
                as DataParameter;
        expect(parameter.data, isNull);
        final imageData = Uint8List(0);
        configuration.toneCurveImage = imageData;
        expect(parameter.data, imageData);
      });

      test('change from file', () {
        final parameter =
            configuration.parameters.firstWhere(
                  (e) => e.name == 'inputTextureToneCurve',
                )
                as DataParameter;
        expect(parameter.file, isNull);
        final file = File('demo.jpeg');
        configuration.toneCurveImageFile = file;
        expect(parameter.file, file);
      });
    });
  });
}
