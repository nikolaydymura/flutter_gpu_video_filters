import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'generated.mocks.dart';

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
  setUp(() async {
    mockFilterApi = MockFilterApi();
    mockAssetBundle = FakeAssetBundle();
    configuration = PassthroughFilterConfiguration(
      filterApi: mockFilterApi,
      assetBundle: mockAssetBundle,
    );
    when(mockFilterApi.create(any, any, any, any, any))
        .thenAnswer((_) async => 101);
  });
  tearDown(() {
    verifyNoMoreInteractions(mockFilterApi);
  });
  group('configuration ready', () {
    setUp(() async {
      await configuration.prepare();
    });
    tearDown(() {
      verify(mockFilterApi.create('vertex', 'fragment', any, any, any))
          .called(1);
    });
    test('GLSliderComputeFloatParameter', () async {
      final parameter = GLSliderComputeFloatParameter('inputValue', 'Value', 0);
      parameter.onUpdate = (_) {};
      parameter.value = 1;
      await parameter.update(configuration);
    });
    test('GLFloatParameter', () async {
      final parameter = GLFloatParameter('inputValue', 'Value', 0);
      parameter.value = 1;
      await parameter.update(configuration);
      verify(mockFilterApi.setFloatParameter(101, 'inputValue', 1.0));
    });
    test('GLIntParameter', () async {
      final parameter = GLIntParameter('inputValue', 'Value', 0);
      parameter.value = 1.5;
      await parameter.update(configuration);
      verify(mockFilterApi.setFloatParameter(101, 'inputValue', 1.0));
    });
    test('GLBoolParameter', () async {
      final parameter = GLBoolParameter('inputValue', 'Value', false);
      parameter.value = true;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', 1),
      );
    });
    test('GLTemperatureParameter', () async {
      final parameter = GLTemperatureParameter('inputValue', 'Value', 5000);
      parameter.value = 5003;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', 0.00018),
      );

      parameter.value = 4995;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', -0.002),
      );
    });
    test('GLTintParameter', () async {
      final parameter = GLTintParameter('inputValue', 'Value', 100);
      parameter.value = 99;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', 0.99),
      );
    });
    test('GLSliderFloatParameter', () async {
      final parameter = GLSliderFloatParameter('inputValue', 'Value', 0);
      parameter.value = 1;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', 1.0),
      );
    });
    test('GLColorIntensityParameter', () async {
      final parameter = GLColorIntensityParameter('inputValue', 'Value', 0);
      parameter.value = 5;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(101, 'inputValue', 0.0196078431372549),
      );
    });
    test('GLPointParameter', () async {
      final parameter =
          GLPointParameter('inputValue', 'Value', const Point(0.0, 0.0));
      parameter.value = const Point(10.0, 5.0);
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([10.0, 5.0]),
        ),
      );
    });
    test('GLVec3Parameter', () async {
      final parameter = GLVec3Parameter('inputValue', 'Value', Vector3.zero());
      parameter.value = Vector3(1.0, 0, 2.0);
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0, 2.0]),
        ),
      );
    });
    test('GLMat3Parameter', () async {
      final parameter = GLMat3Parameter(
        'inputValue',
        'Value',
        Matrix3.zero(),
      );
      parameter.value = Matrix3.fromList([1.0, 0, 0, 0, 0, 0, 0, 0, 2.0]);
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0]),
        ),
      );
    });
    test('GLMat4Parameter', () async {
      final parameter = GLMat4Parameter(
        'inputValue',
        'Value',
        Matrix4.identity(),
      );
      parameter.value = Matrix4.identity().copyWith(items: {10: 2.0});
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([
            1.0,
            0.0,
            0.0,
            0.0,
            0.0,
            1.0,
            0.0,
            0.0,
            0.0,
            0.0,
            2.0,
            0.0,
            0.0,
            0.0,
            0.0,
            1.0
          ]),
        ),
      );
    });
    test('GLColorParameter', () async {
      final parameter = GLColorParameter('inputValue', 'Value', Colors.black);
      parameter.value = Colors.orange;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0.596078431372549, 0.0]),
        ),
      );
    });
    test('GLAspectRatioParameter', () async {
      final parameter =
          GLAspectRatioParameter('inputValue', 'Value', Size.zero);
      parameter.value = const Size(640, 320);
      await parameter.update(configuration);
      verify(
        mockFilterApi.setFloatParameter(
          101,
          'inputValue',
          2.0,
        ),
      );
    });
    group('GLBitmapParameter', () {
      test('from asset', () async {
        final parameter = GLBitmapParameter('inputValue', 'Value');
        parameter.asset = 'demo.jpeg';
        await parameter.update(configuration);
        verify(
          mockFilterApi.setBitmapSourceParameter(
            101,
            'inputValue',
            true,
            'demo.jpeg',
          ),
        );
      });
      test('from file', () async {
        final parameter = GLBitmapParameter('inputValue', 'Value');
        final file = File('demo.jpeg');
        parameter.file = file;
        await parameter.update(configuration);
        verify(
          mockFilterApi.setBitmapSourceParameter(
            101,
            'inputValue',
            false,
            file.absolute.path,
          ),
        );
      });
      test('from data', () async {
        final parameter = GLBitmapParameter('inputValue', 'Value');
        final data = Uint8List(0);
        parameter.data = data;
        await parameter.update(configuration);
        verify(mockFilterApi.setBitmapParameter(101, 'inputValue', data));
      });
    });
  });
  group('configuration not ready', () {
    test('GLFloatParameter', () async {
      final parameter = GLFloatParameter('inputValue', 'Value', 0);
      parameter.value = 1;
      await parameter.update(configuration);
      verifyNever(mockFilterApi.setFloatParameter(101, 'inputValue', 1.0));
    });
    test('GLBoolParameter', () async {
      final parameter = GLBoolParameter('inputValue', 'Value', false);
      parameter.value = true;
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatParameter(101, 'inputValue', 1),
      );
    });
    test('GLSliderFloatParameter', () async {
      final parameter = GLSliderFloatParameter('inputValue', 'Value', 0);
      parameter.value = 1;
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatParameter(101, 'inputValue', 0.99),
      );
    });
    test('GLPointParameter', () async {
      final parameter =
          GLPointParameter('inputValue', 'Value', const Point(0.0, 0.0));
      parameter.value = const Point(10.0, 5.0);
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([10.0, 5.0]),
        ),
      );
    });
    test('GLVec3Parameter', () async {
      final parameter = GLVec3Parameter('inputValue', 'Value', Vector3.zero());
      parameter.value = Vector3(1.0, 0, 2.0);
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0, 2.0]),
        ),
      );
    });
    test('GLMat3Parameter', () async {
      final parameter = GLMat3Parameter(
        'inputValue',
        'Value',
        Matrix3.zero(),
      );
      parameter.value = Matrix3.fromList([1.0, 0, 0, 0, 0, 0, 0, 0, 2.0]);
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0]),
        ),
      );
    });
    test('GLMat4Parameter', () async {
      final parameter = GLMat4Parameter(
        'inputValue',
        'Value',
        Matrix4.identity(),
      );
      parameter.value = Matrix4.identity().copyWith(items: {10: 2.0});
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([
            1.0,
            0.0,
            0.0,
            0.0,
            0.0,
            1.0,
            0.0,
            0.0,
            0.0,
            0.0,
            2.0,
            0.0,
            0.0,
            0.0,
            0.0,
            1.0
          ]),
        ),
      );
    });
    test('GLColorParameter', () async {
      final parameter = GLColorParameter('inputValue', 'Value', Colors.black);
      parameter.value = Colors.orange;
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatArrayParameter(
          101,
          'inputValue',
          Float64List.fromList([1.0, 0.596078431372549, 0.0]),
        ),
      );
    });
    test('GLAspectRatioParameter', () async {
      final parameter =
          GLAspectRatioParameter('inputValue', 'Value', Size.zero);
      parameter.value = const Size(640, 320);
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setFloatParameter(
          101,
          'inputValue',
          2.0,
        ),
      );
    });
    test('from asset', () async {
      final parameter = GLBitmapParameter('inputValue', 'Value');
      parameter.asset = 'demo.jpeg';
      await parameter.update(configuration);
      verifyNever(
        mockFilterApi.setBitmapSourceParameter(
          101,
          'inputValue',
          true,
          'demo.jpeg',
        ),
      );
    });
  });

  /*
  test('CGPositionParameter', () async {
    final parameter = CGPositionParameter(
      'inputValue',
      'Value',
      const Point(
        0.0,
        0.0,
      ),
    );
    parameter.value = const Point(640.0, 80.0);
    await parameter.update(configuration);
    verify(
      mockFilterApi.setCIVectorParameter(
        101,
        'inputValue',
        [640.0, 80.0],
      ),
    );
  });
  test('CIVectorParameter', () async {
    final parameter = CIVectorParameter(
      'inputValue',
      'Value',
      [0.0, 0.0],
    );
    parameter.value = [640.0, 80.0];
    await parameter.update(configuration);
    verify(
      mockFilterApi.setCIVectorParameter(
        101,
        'inputValue',
        [640.0, 80.0],
      ),
    );
  });
  test('CIVectorParameter', () async {
    final parameter = CIVectorParameter(
      'inputValue',
      'Value',
      [0.0, 0.0, 0.0],
      3,
    );
    parameter.value = [640.0, 80.0];
    verifyNever(
      mockFilterApi.setCIVectorParameter(
        101,
        'inputValue',
        [0.0, 0.0, 0.0],
      ),
    );
  });
  test('CGAffineTransformParameter', () async {
    final parameter = CGAffineTransformParameter(
      'inputValue',
      'Value',
      const CGAffineTransform(),
    );
    final affineTransform = const CGAffineTransform().copyWith();
    parameter.value = affineTransform;
    await parameter.update(configuration);
    expect(parameter.value, affineTransform);
    verify(
      mockFilterApi.setNSValueParameter(
        101,
        'inputValue',
        [1.0, 0.0, 0.0, 1.0, 0.0, 0.0],
      ),
    );
  });
  group('NSDataParameter', () {
    test('from asset', () async {
      final parameter = NSDataParameter('inputValue', 'Value');
      parameter.asset = 'demo.jpeg';
      await parameter.update(configuration);
      verify(
        mockFilterApi.setNSDataSourceParameter(
          101,
          'inputValue',
          true,
          'demo.jpeg',
        ),
      );
    });
    test('from file', () async {
      final parameter = NSDataParameter('inputValue', 'Value');
      final file = File('demo.jpeg');
      parameter.file = file;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setNSDataSourceParameter(
          101,
          'inputValue',
          false,
          file.absolute.path,
        ),
      );
    });
    test('from data', () async {
      final parameter = NSDataParameter('inputValue', 'Value');
      final data = Uint8List(0);
      parameter.data = data;
      await parameter.update(configuration);
      verify(mockFilterApi.setNSDataParameter(101, 'inputValue', data));
    });
  });
  group('CIImageParameter', () {
    test('from asset', () async {
      final parameter = CIImageParameter('inputValue', 'Value');
      parameter.asset = 'demo.jpeg';
      await parameter.update(configuration);
      verify(
        mockFilterApi.setCIImageSourceParameter(
          101,
          'inputValue',
          true,
          'demo.jpeg',
        ),
      );
    });
    test('from file', () async {
      final parameter = CIImageParameter('inputValue', 'Value');
      final file = File('demo.jpeg');
      parameter.file = file;
      await parameter.update(configuration);
      verify(
        mockFilterApi.setCIImageSourceParameter(
          101,
          'inputValue',
          false,
          file.absolute.path,
        ),
      );
    });
    test('from data', () async {
      final parameter = CIImageParameter('inputValue', 'Value');
      final data = Uint8List(0);
      parameter.data = data;
      await parameter.update(configuration);
      verify(mockFilterApi.setCIImageDataParameter(101, 'inputValue', data));
    });
  });
  test('NSStringParameter', () async {
    final parameter = NSStringParameter('inputValue', 'Value', '');
    parameter.value = 'hello';
    await parameter.update(configuration);
  });*/
}
