part of gpu_video_filters;

class GPULookupTableConfiguration extends GPUFilterConfiguration {
  final NumberParameter _cubeDimension;
  final DataParameter _cubeData;

  GPULookupTableConfiguration()
      : _cubeDimension =
            _FloatParameter('inputCubeDimension', 'Cube Dimension', 2),
        _cubeData = _BitmapParameter('inputCubeData', 'Cube Data'),
        super('CIColorCube');

  set cubeDimension(int value) {
    _cubeDimension.value = value;
  }

  set cubeData(Uint8List value) {
    _cubeData.data = value;
    _cubeData.asset = null;
    _cubeData.file = null;
  }

  set cubeDataAsset(String value) {
    _cubeData.data = null;
    _cubeData.asset = value;
    _cubeData.file = null;
  }

  set cubeDataFile(File value) {
    _cubeData.data = null;
    _cubeData.asset = null;
    _cubeData.file = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_cubeDimension, _cubeData];
}
