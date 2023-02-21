part of flutter_gpu_video_filters;

class GPUFalseColorConfiguration extends GPUFilterConfiguration {
  final ColorParameter _firstColor;
  final ColorParameter _secondColor;

  GPUFalseColorConfiguration()
      : _firstColor = GLColorParameter(
          'inputFirstColor',
          'First Color',
          const Color.fromRGBO(0, 0, 127, 1.0),
        ),
        _secondColor = GLColorParameter(
          'inputSecondColor',
          'Second Color',
          const Color.fromRGBO(255, 0, 0, 1.0),
        ),
        super('FalseColor');

  set firstColor(Color value) {
    _firstColor.value = value;
  }

  set secondColor(Color value) {
    _secondColor.value = value;
  }

  @override
  List<ConfigurationParameter> get parameters => [_firstColor, _secondColor];
}
