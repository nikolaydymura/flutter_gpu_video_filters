import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../generated.mocks.dart';

class PassthroughFilterConfiguration extends GPUFilterConfiguration {
  PassthroughFilterConfiguration({super.assetBundle, super.filterApi})
    : super('Passthrough');
}

class FakeAssetBundle extends Fake implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) {
    if (key == 'packages/flutter_gpu_video_filters/shaders/Vertex.glsl') {
      return Future.value('vertex');
    } else if (key ==
        'packages/flutter_gpu_video_filters/shaders/Passthrough.glsl') {
      return Future.value('fragment');
    }
    return Future.value('');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFilterApi mockFilterApi;
  late FakeAssetBundle mockAssetBundle;
  late PassthroughFilterConfiguration configuration;
  setUp(() {
    mockFilterApi = MockFilterApi();
    mockAssetBundle = FakeAssetBundle();
    configuration = PassthroughFilterConfiguration(
      filterApi: mockFilterApi,
      assetBundle: mockAssetBundle,
    );
    when(
      mockFilterApi.create(any, any, any, any, any),
    ).thenAnswer((_) async => 101);
  });
  tearDown(() {
    verifyNoMoreInteractions(mockFilterApi);
  });
  group('GPUFilterConfiguration', () {
    test('prepare', () async {
      expect(configuration.ready, false);
      await configuration.prepare();
      expect(configuration.ready, true);
      verify(
        mockFilterApi.create('vertex', 'fragment', any, any, any),
      ).called(1);
    });
    test('dispose', () async {
      expect(configuration.ready, false);
      await configuration.prepare();
      expect(configuration.ready, true);
      await configuration.dispose();
      expect(configuration.ready, false);
      verify(
        mockFilterApi.create('vertex', 'fragment', any, any, any),
      ).called(1);
      verify(mockFilterApi.dispose(101)).called(1);
    });
    test('dispose when not ready', () async {
      expect(configuration.ready, false);
      await configuration.dispose();
      expect(configuration.ready, false);
    });
    group('exportVideoFile', () {
      setUp(() async {
        await configuration.prepare();
        when(
          mockFilterApi.exportVideoFile(101, true, any, any, 'mov', 1000),
        ).thenAnswer((_) async => 201);
        when(
          mockFilterApi.exportVideoFile(101, false, any, any, 'mp4', 1000),
        ).thenAnswer((_) async => 201);
      });
      tearDown(() async {
        await configuration.dispose();
        verify(
          mockFilterApi.create('vertex', 'fragment', any, any, any),
        ).called(1);
        verify(mockFilterApi.dispose(101)).called(1);
      });
      test('export from asset', () async {
        const asset = 'demo.mov';
        final output = File(asset);
        final config = VideoExportConfig(AssetInputSource(asset), output);
        await configuration.update();
        configuration.exportVideoFile(config).listen((event) {});
        await Future.delayed(const Duration(milliseconds: 100));
        verify(
          mockFilterApi.exportVideoFile(
            101,
            true,
            'demo.mov',
            output.absolute.path,
            'mov',
            1000,
          ),
        ).called(1);
      });
    });
  });
}
