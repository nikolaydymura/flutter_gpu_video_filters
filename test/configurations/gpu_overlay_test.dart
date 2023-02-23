import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPUOverlayConfiguration configuration;
  setUp(() {
    configuration = GPUOverlayConfiguration();
  });
  group('GPUOverlayConfiguration', () {
    group('inputImageTexture2', () {
      test('change from asset', () {
        final parameter = configuration.parameters
            .firstWhere((e) => e.name == 'inputImageTexture2') as DataParameter;
        expect(parameter.asset, isNull);
        configuration.image2Asset = 'demo.jpeg';
        expect(parameter.asset, 'demo.jpeg');
      });
      test('change from binary', () {
        final parameter = configuration.parameters
            .firstWhere((e) => e.name == 'inputImageTexture2') as DataParameter;
        expect(parameter.data, isNull);
        final imageData = Uint8List(0);
        configuration.image2 = imageData;
        expect(parameter.data, imageData);
      });
      test('change from file', () {
        final parameter = configuration.parameters
            .firstWhere((e) => e.name == 'inputImageTexture2') as DataParameter;
        expect(parameter.file, isNull);
        final file = File('demo.jpeg');
        configuration.image2File = file;
        expect(parameter.file, file);
      });
    });
  });
}
