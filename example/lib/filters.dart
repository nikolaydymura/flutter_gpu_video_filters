import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

class FilterItem {
  final String name;
  final GPUFilterConfiguration configuration;

  FilterItem(this.name, this.configuration);
}

final kFailedFilters = [
  FilterItem(
    'Monochrome',
    FlutterVideoFilters.createFilter<GPUMonochromeConfiguration>(
      displayName: 'Monochrome',
    )
      ..color = Colors.orange
      ..intensity = 0.75,
  ),
].sorted((a, b) => a.name.compareTo(b.name));