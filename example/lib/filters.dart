import 'package:collection/collection.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

class FilterItem {
  final String name;
  final GPUFilterConfiguration configuration;

  FilterItem(this.name, this.configuration);
}

final kFailedFilters = [
  FilterItem(
    'Square Lookup Table',
    FlutterVideoFilters.createFilter<GPUSquareLookupTableConfiguration>(
        displayName: 'Square Lookup Table',
      )
      ..lutImageAsset = 'images/lookup_amatorka.png'
      ..intensity = 0.75,
  ),
  FilterItem(
    'HALD Lookup Table',
    FlutterVideoFilters.createFilter<GPUHALDLookupTableConfiguration>(
        displayName: 'HALD Lookup Table',
      )
      ..lutImageAsset = 'images/lookup_hald.png'
      ..intensity = 0.75,
  ),
  FilterItem(
    'Brightness & Contrast',
    BunchFilterConfiguration('shaders', [
      GPUBrightnessConfiguration()..brightness = 0.5,
      GPUContrastConfiguration()..contrast = 2.0,
    ]),
  ),
].sorted((a, b) => a.name.compareTo(b.name));
