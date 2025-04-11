import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GPULaplacianConfiguration configuration;
  setUp(() {
    configuration = GPULaplacianConfiguration();
  });
  group('GPULaplacianConfiguration', () {
    test('change inputConvolutionMatrix', () {
      final parameter =
          configuration.parameters.firstWhere(
                (e) => e.name == 'inputConvolutionMatrix',
              )
              as Mat3Parameter;
      expect(parameter.value.storage, [
        0.5,
        1.0,
        0.5,
        1.0,
        -6.0,
        1.0,
        0.5,
        1.0,
        0.5,
      ]);
      configuration.convolutionKernel = Matrix3.fromList([
        0.0,
        1.0,
        0.5,
        1.0,
        -6.0,
        1.0,
        0.5,
        1.0,
        0.0,
      ]);
      expect(parameter.value.storage, [
        0.0,
        1.0,
        0.5,
        1.0,
        -6.0,
        1.0,
        0.5,
        1.0,
        0.0,
      ]);
    });
  });
}
