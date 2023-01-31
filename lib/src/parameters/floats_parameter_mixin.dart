part of flutter_gpu_video_filters;

mixin _FloatsParameter on ConfigurationParameter {
  List<double> get values;

  Float32List get floats => Float32List.fromList(values);
}
